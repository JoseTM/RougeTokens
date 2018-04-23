/*

  Contract to implement the TGE/crowdfunding of the Rouge Project

*/

pragma solidity ^0.4.18;

contract RGX {
    function balanceOf(address _owner) public view returns (uint256 balance);
    function discountMultiplier() public view returns (uint8 discount);
}

contract RGE {
    function balanceOf(address _owner) public view returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
}

contract RougeTGE {
    
    string public version = 'v0.2';
    
    address owner; 

    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }

    uint public fundingStart;
    uint public fundingEnd;
    
    modifier beforeTGE() {
        require(fundingStart > now);
        _;
    }

    modifier TGEOpen() {
        require(fundingStart <= now && now < fundingEnd);
        _;
    }
    
    modifier afterTGE() {
        require(now >= fundingEnd);
        _;
    }

    function isFundingOpen() constant public returns (bool yes) {
        return(fundingStart <= now && now < fundingEnd);
    }

    mapping (address => bool) public kyc;
    mapping (address => uint256) public tokens;
    mapping (address => mapping (address => uint256)) public used;

    function tokensOf(address _who) public view returns (uint256 balance) {
        return tokens[_who];
    }

    uint256 public minFunding = 1; /* in finney */
    uint256 public tokenPrice; /* in wei */

    struct Bonus {
        uint256 funding; // original contribution in finney
        uint256 used;    // already used with bonus contribution in finney
        uint256 tokens;  // RGE token attribution
    }

    function RougeTGE (
                       uint _fundingStart,
                       uint _fundingEnd,
                       uint _tokenPrice
                       ) public {
        owner = msg.sender;
        fundingStart = _fundingStart;
        fundingEnd = _fundingEnd;
        tokenPrice = _tokenPrice; /* in finney */
    }
    
    address rge; 
    address rgxa; 
    address rgxb; 
    address rgx20; 
    address rgx15; 
    address rgx12; 

    function init (
                   address _rge,
                   address _rgxb,
                   address _rgx12
                   ) onlyBy(owner) public {
        rge = _rge;
        rgxb = _rgxb;
        rgx12 = _rgx12;
    }
    
    function () payable TGEOpen() public { 

        require(msg.sender != owner);

        Bonus memory _bonus = Bonus({
            funding: msg.value / 1 finney, used: 0, tokens: 0
        });

        require(_bonus.funding >= minFunding); 

        _bonus = _with_RGXBonus(_bonus, rgxb);
        _bonus = _with_RGXToken(_bonus, rgx12);

        /* standard tokens distribution */
        
        if ( _bonus.funding > _bonus.used ) {

            uint256 _free = _bonus.funding - _bonus.used;
            _bonus.used += _free;
            _bonus.tokens += _free * 1 finney * 10**6 / tokenPrice;

        }

        // check if enough tokens !

        tokens[msg.sender] += _bonus.tokens;
    }
    
    function _with_RGXBonus(Bonus _bonus, address _a) internal returns (Bonus _result) {

        RGX _rgx = RGX(_a);

        uint256 rgxBalance = _rgx.balanceOf(msg.sender);

        if ( used[_rgx][msg.sender] < rgxBalance && _bonus.funding > _bonus.used ) {

            uint256 _free = rgxBalance - used[_rgx][msg.sender];

            if ( _free > _bonus.funding - _bonus.used ) {
                _free = _bonus.funding - _bonus.used;
            }

            uint8 discountMultiplier = _rgx.discountMultiplier();

            _bonus.used += _free;
            _bonus.tokens += _free * 1 finney * 10**6 / tokenPrice * discountMultiplier;
            used[_rgx][msg.sender] += _free;
        }

        return _bonus;
    }

    function _with_RGXToken(Bonus _bonus, address _a) internal returns (Bonus _result) {

        RGX _rgx = RGX(_a);

        uint256 rgxBalance = _rgx.balanceOf(msg.sender);

        if ( used[_rgx][msg.sender] < rgxBalance ) {

            uint256 _free = rgxBalance - used[_rgx][msg.sender];

            uint8 discountMultiplier = _rgx.discountMultiplier() - 1;

            _bonus.tokens += _free * 1 finney * 10**6 / tokenPrice * discountMultiplier;
            used[_rgx][msg.sender] += _free;
        }

        return _bonus;
    }

    function setKYC(address _who, bool _flag) onlyBy(owner) public {
        kyc[_who]= _flag;
    }
    
    function withdraw() public returns (bool success) {

        require(msg.sender != owner); 
        
        // no verification if enough tokens => done in payable already
        
        require(tokens[msg.sender] > 0);
        require(kyc[msg.sender]); 
        
        RGE _rge = RGE(rge);
        
        if ( _rge.transfer(msg.sender, tokens[msg.sender]) ) {
            // XXX to check 
            tokens[msg.sender] = 0;
            return true;
        } 
        
        return false;
        
    }
    

    /* function suspendTGE() onlyBy(owner) public {

       }*/
    
    function withdrawFunding() onlyBy(owner) public {
        msg.sender.transfer(address(this).balance);
    }
    
    function kill() onlyBy(owner) public {
        selfdestruct(owner);
    }

}

/*

  Simple contract to implement ERC20 tokens for the crowdfunding of the Rouge Project (RGX tokens).
  They are based on StandardToken from (https://github.com/ConsenSys/Tokens).

  Differences with standard ERC20 tokens :

   - The tokens can be bought by sending ether to the contract address
     (the price is hardcoded 1 token = 1 finney (0.001 eth).

   - The contract implements two states (Opened & Closed) to let the owner start/stop the funding.

   - At the creation, a discountMultiplier is saved which can be used later on 
     by other contracts (eg to use the tokens as a voucher).

*/

import "./StandardToken.sol";

pragma solidity ^0.4.12;

contract RGXToken is StandardToken {

    enum States {
        Closed,
        Opened
    }

    States public state = States.Closed;

    modifier atState(States _state) {
        require(state == _state);
        _;
    }

    modifier onlyBy(address _account) {
        require(msg.sender == _account);
        _;
    }
    
    function () payable atState(States.Opened) {

      require(msg.sender != owner);
      
      uint256 _value = msg.value / 1 finney;

      require(balances[owner] >= _value && _value > 0);

      balances[owner] -= _value;
      balances[msg.sender] += _value;
      Transfer(owner, msg.sender, _value);
      
    }

    /* ERC20 */
    string public name;
    string public symbol;
    uint8 public decimals = 0;
    string public version = 'v0.7';

    /* RGX */
    address owner; 
    uint8 public discountMultiplier;

    function RGXToken (
        uint8 _discountMultiplier,
        string _name,
        string _symbol,
        uint256 _initialAmount
        ) {
      discountMultiplier = _discountMultiplier;
      name = _name;
      symbol = _symbol;
      owner = msg.sender;
      balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
      totalSupply = _initialAmount;                        // Update total supply
    }

    function openFunding() onlyBy(owner) {
      state = States.Opened;
    }

    function closeFunding() onlyBy(owner) {
      state = States.Closed;
    }

    function isFundingOpen() constant returns (bool yes) {
      return state == States.Opened;
    }

    function withdraw() onlyBy(owner) {
      msg.sender.transfer(this.balance);
    }

}

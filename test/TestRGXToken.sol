pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/RGXToken.sol";

contract TestRGXToken {

  function testInitialBalanceUsingDeployedContract() {
    RGXToken rgx = RGXToken(DeployedAddresses.RGXToken());

    uint expected = 1000;

    Assert.equal(rgx.balanceOf(tx.origin), expected, "Owner should have 1000 RGXToken initially");
  }

  function testInitialBalanceWithNewRGXToken() {
    RGXToken rgx = new RGXToken(10, 'RGX Token (x10 discount)', 'RGX10', 1000);

    uint expected = 1000;
    
    Assert.equal(rgx.balanceOf(this), expected, "Owner should have 10000 RGXToken initially");
  }

}

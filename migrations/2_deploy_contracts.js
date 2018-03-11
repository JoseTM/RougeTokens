var RGXToken = artifacts.require("./RGXToken.sol");
var RGXBonus = artifacts.require("./RGXBonus.sol");

// startFunding set to 19 January, 2038 03:14:07 UTC.

module.exports = function(deployer) {

  deployer.deploy(RGXToken, 'RGX20 Test Token (x20 discount)', 'RGX20', 1000, 2147483647, 20);
  deployer.deploy(RGXBonus, 'RGXB Test Token (x11 discount)', 'RGXB', 2147483647, 11);

};

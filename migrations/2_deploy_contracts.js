var RGXToken = artifacts.require("./RGXToken.sol");

// startFunding set to 19 January, 2038 03:14:07 UTC.

module.exports = function(deployer) {

  deployer.deploy(RGXToken, 'RGX Token (x20 discount)', 'RGX20', 1000, 2147483647, 20);

};

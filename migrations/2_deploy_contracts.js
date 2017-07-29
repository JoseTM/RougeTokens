var RGXToken = artifacts.require("./RGXToken.sol");

module.exports = function(deployer) {

  deployer.deploy(RGXToken, 10, 'RGX Token (x10 discount)', 'RGX10', 1000);

};

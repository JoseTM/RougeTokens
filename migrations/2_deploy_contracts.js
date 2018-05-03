
var RGXA = artifacts.require("./RGXBonus.sol");
var RGXB = artifacts.require("./RGXBonus.sol");

var RGX12 = artifacts.require("./RGXToken.sol");
var RGX9 = artifacts.require("./RGXToken.sol");

var TGE = artifacts.require("./RougeTGE.sol");
var RGEToken = artifacts.require("./RGEToken.sol");

module.exports = async function(deployer) {
  let aInst, bInst;

  var now = Math.floor(Date.now() / 1000)

  // $0.076 / 500 = 0.000152 ETH = 152000000000000 wei
  var price = 152000000000000

  await Promise.all([

    // RGX endFunding set to 19 January, 2038 03:14:07 UT ( 2147483647 )

    deployer.deploy(RGXA, 'RGXA Test Token (x20 discount)', 'RGXA', 2147483647, 20, 0),
    deployer.deploy(RGXB, 'RGXB Test Token (x11 discount)', 'RGXB', 2147483647, 11, 0),

    deployer.deploy(RGX12, 'RGX12 Test Token (x12 discount)', 'RGX12', 200000, now, 12),
    deployer.deploy(RGX9, 'RGX9 Test Token (x9 discount)', 'RGX9', 200000, now, 9),

    // TEST TGE => 1 hour crowdfounding starting from now

    deployer.deploy(TGE, now, now+3600, price),
    deployer.deploy(RGEToken, now+3600)

  ]);

  instances = await Promise.all([
    RGXA.deployed(),
    RGXB.deployed(),
    RGX12.deployed(),
    RGX9.deployed(),
    TGE.deployed(),
    RGEToken.deployed()
  ])

  rgxa = instances[0];
  rgxb = instances[1];
  rgx12 = instances[2];
  rgx9 = instances[3];
  tge = instances[4];
  rge = instances[5];

  results = await Promise.all([
    tge.init(rge.address, rgxa.address, rgxb.address, rgx12.address, rgx9.address),
    rge.startCrowdsaleY0(tge.address)
  ]);

};

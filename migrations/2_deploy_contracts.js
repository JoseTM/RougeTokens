
var RGXB = artifacts.require("./RGXBonus.sol");
var RGX12 = artifacts.require("./RGXToken.sol");

var TGE = artifacts.require("./RougeTGE.sol");
var RGEToken = artifacts.require("./RGEToken.sol");

module.exports = async function(deployer) {
  let aInst, bInst;

  var now = Math.floor(Date.now() / 1000)

  // $0.076 / 500 = 0.000152 ETH = 152000000000000 wei
  var price = 152000000000000

  await Promise.all([

    // RGXB RGX12 endFunding set to 19 January, 2038 03:14:07 UT ( 2147483647 )

    deployer.deploy(RGXB, 'RGXB Test Token (x11 discount)', 'RGXB', 2147483647, 11, 0),
    deployer.deploy(RGX12, 'RGX12 Test Token (x12 discount)', 'RGX12', 200000, now, 12),

    // TEST TGE => 1 hour crowdfounding starting from now

    deployer.deploy(TGE, now, now+3600, price),
    deployer.deploy(RGEToken, now+3600)

  ]);

  instances = await Promise.all([
    RGXB.deployed(),
    RGX12.deployed(),
    TGE.deployed(),
    RGEToken.deployed()
  ])

  rgxb = instances[0];
  rgx12 = instances[1];
  tge = instances[2];
  rge = instances[3];

  results = await Promise.all([
    tge.init(rge.address, rgxb.address, rgx12.address),
    rge.startCrowdsaleY0(tge.address)
  ]);

};

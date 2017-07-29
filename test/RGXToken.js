var RGXToken = artifacts.require("./RGXToken.sol");

contract('RGXToken', function(accounts) {

  var owner = accounts[0];
  const initialBalance_owner = web3.eth.getBalance(owner);
  console.log(web3.fromWei(initialBalance_owner).toString())

  var user1 = accounts[2];
  const initialBalance_user1 = web3.eth.getBalance(user1)
  console.log(web3.fromWei(initialBalance_user1).toString())

  it("should put 1000 RGXToken in the owner account", function() {
    return RGXToken.deployed().then(function(instance) {
      return instance.balanceOf.call(owner);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 1000, "1000 wasn't in the owner account");
    });
  });

  it("should have funding closed at contract creation", function() {
    return RGXToken.deployed().then(function(instance) {
      RGX = instance;
      return RGX.isFundingOpen.call();
    }).then(function(isOpen) {
      assert.equal(isOpen, false, "funding is not closed at contract creation");
    });
  });
  
  it("has funding opened after owner call openFunding", function() {
    return RGXToken.deployed().then(function(instance) {
      RGX = instance;
      return RGX.openFunding();
    }).then(function() {
      return RGX.isFundingOpen.call();
    }).then(function(isOpen) {
      assert.equal(isOpen, true, "funding is still closed after owner call openFunding");
    });
  });
  
  it("sending 10 finney should credit 10 RGXToken in the user account", function() {
    var RGX;

    var owner_RGX_start_balance;
    var user1_RGX_start_balance;
    var owner_RGX_end_balance;
    var user1_RGX_end_balance;
    var amount = 10;
    
    return RGXToken.deployed().then(function(instance) {
      RGX = instance;
      return RGX.openFunding();
    }).then(function() {
      return RGX.balanceOf.call(owner);
    }).then(function(balance) {
      owner_RGX_start_balance = balance.toNumber();
      return RGX.balanceOf.call(user1);
    }).then(function(balance) {
      user1_RGX_start_balance = balance.toNumber();
      RGX.sendTransaction({from: user1, gas: 100000, value: web3.toWei(amount, "finney")});
    }).then(function() {
      return RGX.balanceOf.call(owner);
    }).then(function(balance) {
      owner_RGX_end_balance = balance.toNumber();
      return RGX.balanceOf.call(user1);
    }).then(function(balance) {
      user1_RGX_end_balance = balance.toNumber();
      assert.equal(owner_RGX_end_balance, owner_RGX_start_balance - amount, "Amount wasn't correctly taken from the owner (sender)");
      assert.equal(user1_RGX_end_balance, user1_RGX_start_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });


});

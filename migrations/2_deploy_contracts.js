// var Mortal = artifacts.require("./Mortal.sol");
var StakeOne = artifacts.require("./StakeOne.sol");

module.exports = function(deployer) {
  // deploys from testrpc web3.eth.accounts[0], not window MetaMask
  // deployer.deploy(Mortal);
  deployer.deploy(StakeOne, {from: web3.eth.accounts[0]})
  .then(function() {
    web3.eth.sendTransaction({
      from: web3.eth.accounts[0],
      to: "0xfd2938c85530DdA11Bb9eFd08B12283d62664764",
      value: web3.toWei(5, 'ether')
    });
  })
  .then(function() {
    // not StakeOne.new() (new instance)
    return StakeOne.deployed();
  })
  .then(function(instance) {
    instance.registerMember("satoshi", "0xfd2938c85530DdA11Bb9eFd08B12283d62664764")
    return instance;
  })
  .then(function(instance) {
    return instance.getMembers()
  })
  .then(function(members) {
    console.log(members[0]);
    console.log(members[1]);
  })
};

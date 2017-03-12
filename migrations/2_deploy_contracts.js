var NameRegistry = artifacts.require("./NameRegistry.sol");
var MultiSig = artifacts.require("./MultiSig.sol");
var StakeOne = artifacts.require("./StakeOne.sol");

module.exports = function(deployer) {
  // deploys from testrpc web3.eth.accounts[0], not window MetaMask
  // deployer.deploy(NameRegistry, 'Alex', {from: web3.eth.accounts[0]});
  // deployer.deploy(NameRegistry);
  // deployer.deploy(MultiSig, 2, {from: web3.eth.accounts[0]});
  deployer.deploy(StakeOne)
};

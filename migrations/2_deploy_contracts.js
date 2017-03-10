var NameRegistry = artifacts.require("./NameRegistry.sol");

module.exports = function(deployer) {
  // deploys from testrpc web3.eth.accounts[0], not window MetaMask
  deployer.deploy(NameRegistry, 'Alex', {from: web3.eth.accounts[0]});
};

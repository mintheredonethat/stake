var NameRegistry = artifacts.require("./NameRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(NameRegistry);
};

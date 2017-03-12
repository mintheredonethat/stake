var StakeOne = artifacts.require("./StakeOne.sol");

contract("StakeOne", function(accounts) {

  // On deploy

  it("Should set the owner of the contract", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      var owner;
      return instance.owner.call()

      .then(function(response) {
        owner = response;
        assert.equal(owner, accounts[0], "Owner not set");
      })
    })
  })

  it("Should set the 'required' field", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      var required;
      return instance.required.call()

      .then(function(response) {
        required = response;
        assert.equal(required, 1, "'required' field not set");
      });
    });
  })

  it("Should set current TransactionState to noTransaction", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      var currentState;
      return instance.currentState.call()

      .then(function(response) {
        currentState = response;
        assert.equal(currentState, 0, "currentState not set");
      })
    })
  })

  // Member registry functionality

  it("Should registerMember & getMembers", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      var memberCount;
      return instance.registerMember("Satoshi", accounts[0])

      .then(function() {
        var name;
        var addr;
        return instance.getMembers()

        .then(function(response) {
          name = web3.toAscii(response[0][0]);
          addr = response[1][0];

          // .include because returned name is padded w/ \u0000
          assert.include(name, "Satoshi", "Did not register/get member");
          assert.equal(addr, accounts[0], "Did not register/get member");
        })
      });
    });
  });

  // MultiSig functionality

  it("Should depositStake & getBalance", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      var bal;
      return instance.depositStake({from: accounts[0], value: web3.toWei(10, 'ether')})

      .then(function() {
        return instance.getBalance()

        .then(function(response) {
          bal = response;
          assert.isAtLeast(bal, web3.toWei(10), "Did not depositStake/getBalance");
        })
      })
    })
  })

})

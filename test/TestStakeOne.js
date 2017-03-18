var StakeOne = artifacts.require("./StakeOne.sol");

// On deploy
contract("StakeOne Deployment", function(accounts) {
  it("Should set owner of contract", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      return instance.owner.call()
    })
    .then(function(owner) {
      assert.equal(owner, accounts[0], "Owner not set");
      assert.notEqual(owner, accounts[1], "Owner not set");
    })
  })

  it("Should set currentState to noTransaction", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      return instance.currentState.call()
    })
    .then(function(currentState) {
      assert.equal(currentState, 0, "currentState not set");
      assert.notEqual(currentState, 1, "currentState not set");
    })
  })

  // Deployment automatically registers a member
  it("Should getMembers", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      return instance.getMembers()
    })
    .then(function(members) {
      var name = web3.toAscii(members[0][0]);
      var addr = members[1][0];
      
      // asserting name tough because \u0000 padding for string
      assert.include(name, "Satoshi", "Did not register/getMember");
      assert.include(members[1], addr, "Members does not include address; getMembers broken");
    })
  })
})

// NameReg functionality after deployed
contract("StakeOne Registry", function(accounts) {
  it("Should registerMember; prove by checking if required incremented", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      instance.registerMember("Vitalik", accounts[0])
      return instance
    })
    .then(function(instance) {
      return instance.required.call()
    })
    .then(function(required) {
      // Not 1 because registration of MM member in deployment
      assert.equal(required, 2, "Required not set");
      assert.notEqual(required, 1, "Required not set");
    })
  })
})

// Multisig Functionality
contract("StakeOne MultiSig", function(accounts) {
  it("Should getBalance", function() {

  })

  it("Should depositStake", function() {

  })

  it("Should makeWithdrawal", function() {

  })

  it("Should getCurrentWithdrawal", function() {

  })

  it("Should confirmTransaction", function() {

  })
})

  // it("Should depositStake | getBalance", function() {
  //   return StakeOne.deployed()
  //
  //   .then(function(instance) {
  //     return instance.registerMember("Satoshi", accounts[0])
  //
  //     .then(function() {
  //       return instance.depositStake({from: accounts[0], value: web3.toWei(10, 'ether')})
  //
  //       .then(function() {
  //         return instance.getBalance.call()
  //
  //         .then(function(response) {
  //           assert.isAtLeast(response, web3.toWei(10), "Did not depositStake | getBalance");
  //           return instance.proposeWithdrawal(accounts[1], web3.toWei(5, 'ether'), {from: accounts[0]})
  //
  //           .then(function() {
  //             return instance.currentState()
  //
  //             .then(function(currentState) {
  //               assert.equal(currentState, 1, 'Current state not set')
  //             })
  //           })
  //         })
  //       })
  //     })
  //   })
  // })

  // it("Should makeWithdrawal | currentState | getCurrentWithdrawal", function() {
  //   return StakeOne.deployed()
  //
  //   .then(function(instance) {
  //     return instance.makeWithdrawal(accounts[1], web3.toWei(5, 'ether'), {from: accounts[0]})
  //
  //     .then(function() {
  //       return instance.currentState()
  //
  //       .then(function(currentState) {
  //         var id, destination, amount, numConfirm;
  //
  //         // currentState changes upon makeTransaction
  //         assert.equal(currentState, 1, "currentState not set")
  //         return instance.getCurrentWithdrawal({from: accounts[0]})
  //
  //         .then(function(response) {
  //           id = response[0];
  //           destination = response[1];
  //           amount = response[2];
  //           numConfirm = response[3];
  //
  //           // new TX, transactions[0], has the following properties
  //           assert.equal(id, 0, "ID not set");
  //           assert.equal(destination, accounts[1], "Destination not set");
  //           assert.equal(amount, web3.toWei(5, 'ether'), "amount not set");
  //           assert.equal(numConfirm, 0, "numConfirm not set");
  //
  //           return instance.confirmWithdrawal()
  //
  //           .then(function() {
  //
  //           })
  //         })
  //       })
  //     })
  //   })
  // })

  // it("Should confirmTransaction", function() {
  //   return StakeOne.deployed()
  //
  //   .then(function(instance) {
  //     return instance.confirmTransction()
  //
  //
  //   })
  // })

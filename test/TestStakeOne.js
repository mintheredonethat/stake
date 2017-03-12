var StakeOne = artifacts.require("./StakeOne.sol");

contract("StakeOne", function(accounts) {

  // On deploy

  it("Should set owner of contract", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      return instance.owner.call()

      .then(function(owner) {
        assert.equal(owner, accounts[0], "Owner not set");
        assert.notEqual(owner, accounts[1], "Owner not set");
      })
    })
  })

  it("Should set currentState to noTransaction", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      return instance.currentState.call()

      .then(function(currentState) {
        assert.equal(currentState, 0, "currentState not set");
        assert.notEqual(currentState, 1, "currentState not set");
      })
    })
  })

  // Member registry functionality

  it("Should registerMember | required | getMembers", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      return instance.registerMember("Satoshi", accounts[0])

      .then(function() {
        return instance.required.call()

        .then(function(required) {
          var name;
          var addr;

          assert.equal(required, 1, 'requried not set');
          assert.notEqual(required, 0, "Required not set");
          
          return instance.getMembers()

          .then(function(response) {
            name = web3.toAscii(response[0][0]);
            addr = response[1][0];

            assert.include(name, "Satoshi", "Did not register/get member");
            assert.equal(addr, accounts[0], "Did not register/get member");
            assert.notEqual(addr, accounts[1], "Did not register/get");
          })
        })
      })
    })
  })

  // Multisig Functionality

  it("Should depositStake | getBalance", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      return instance.registerMember("Satoshi", accounts[0])

      .then(function() {
        return instance.depositStake({from: accounts[0], value: web3.toWei(10, 'ether')})

        .then(function() {
          return instance.getBalance()

          .then(function(response) {
            assert.isAtLeast(response, web3.toWei(10), "Did not depositStake | getBalance");
          })
        })
      })
    })
  })

  it("Should makeWithdrawal | currentState | getCurrentWithdrawal", function() {
    return StakeOne.deployed()

    .then(function(instance) {
      var currentState;
      // var transactionsCount;
      return instance.makeWithdrawal(accounts[1], web3.toWei(5, 'ether'), {from: accounts[0]})

      .then(function() {
        var currentState;
        return instance.currentState()

        .then(function(response) {
          var id, destination, amount, numConfirm;
          currentState = response;

          // currentState changes upon makeTransaction
          assert.equal(currentState, 1, "currentState not set")
          return instance.getCurrentWithdrawal({from: accounts[0]})

          .then(function(response) {
            id = response[0];
            destination = response[1];
            amount = response[2];
            numConfirm = response[3];

            // new TX, transactions[0], has the following properties
            assert.equal(id, 0, "ID not set");
            assert.equal(destination, accounts[1], "Destination not set");
            assert.equal(amount, web3.toWei(5, 'ether'), "amount not set");
            assert.equal(numConfirm, 0, "numConfirm not set");
          })
        })
      })
    })
  })

})


  // it("Should confirmTransaction", function() {
  //   return StakeOne.deployed()
  //
  //   .then(function(instance) {
  //     return instance.confirmTransction()
  //
  //
  //   })
  // })

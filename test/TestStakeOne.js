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

      // asserting name equal tough because \u0000 padding for string
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
      assert.equal(required.toString(), 2, "Required not set");
      assert.notEqual(required.toString(), 1, "Required not set");
    })
  })
})

// Multisig Functionality
contract("StakeOne MultiSig", function(accounts) {
  it("Should getBalance", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      return instance.getBalance();
    })
    .then(function(balance) {
      assert.equal(balance, 0, "Balance failed to initialise to 0");
    })
  })

  it("Should depositStake", function() {
    return StakeOne.deployed()
    // .then(function(instance) {
    //   var event = instance.allEvents().watch({}, '');
    //   event.watch(function(error, result) {
    //     if (error) {
    //       console.log(error);
    //     }
    //     else {
    //       console.log(result);
    //     }
    //   })
    // })
    .then(function(instance) {
      instance.registerMember("alex", accounts[0])
      return instance;
    })
    .then(function(instance) {
      instance.depositStake({from: accounts[0], value: web3.toWei(1, 'ether')})
      return instance;
    })
    .then(function(instance) {
      return instance.getBalance();
    })
    .then(function(bal) {
      assert.equal(web3.fromWei(bal), 1, "Did not depositStake");
    })
  })

  // change requirement? Because can't unlock signer account of MM from deployment
  it("Should proposeWithdrawal", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      instance.proposeWithdrawal(accounts[0], web3.toWei(0.5, 'ether'));
      return instance;
    })
    .then(function(instance) {
      return instance.currentState.call()
    })
    .then(function(currentState) {
      assert.equal(currentState, 1, "currentState not set");
      assert.notEqual(currentState, 0, "currentState not set");
    })
  })

  it("Should getCurrentWithdrawal", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      return instance.getCurrentWithdrawal.call()
    })
    .then(function(w) {
      assert.equal(w[0], 0, "getCurrentWithdrawal Failed (ID)");
      assert.equal(w[1], accounts[0], "getCurrentWithdrawal failed (destination)");
      assert.equal(w[2], web3.toWei(0.5, 'ether'), "getCurrentWithdrawal failed (amount)");
      assert.equal(w[3], 0, "getCurrentWithdrawal failed (numConfirm)");
    })
  })

  it("Should confirmWithdrawal", function() {
    return StakeOne.deployed()
    .then(function(instance) {
      instance.confirmWithdrawal({from: accounts[0]});
      return instance
    })
    .then(function(instance) {
      return instance.getCurrentWithdrawal.call()
    })
    .then(function(w) {
      assert.equal(w[3], 1, "getCurrentWithdrawal failed (numConfirm)");
    })
  })

  // it("Should change currentState & allow for executeWithdrawal", function() {
  //   return StakeOne.deployed()
  //   .then(function(instance) {
  //     // required = 2
  //     // Other required member from deployment
  //     instance.confirmWithdrawal({from: "0xfd2938c85530DdA11Bb9eFd08B12283d62664764"})
  //     return instance;
  //   })
  //   .then(function(instance) {
  //     return instance.currentState.call()
  //   })
  //   .then(function(currentState) {
  //     console.log(currentState);
  //     assert.equal(currentState, 2, "currentState not set");
  //     assert.notEqual(currentState, 1, "currentState not set");
  //   })
  // })
})

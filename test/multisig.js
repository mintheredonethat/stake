var MultiSig = artifacts.require("./MultiSig.sol");

contract('MultiSig', function(accounts) {
  it("Should assign owner of contract as msg.sender", function() {
    return MultiSig.deployed(2, {from: accounts[0]})

    .then(function(instance) {
      var owner;
      var required;
      instance.owner.call()

      .then(function(response) {
        // console.log(response);
        owner = response;
        assert.equal(owner, accounts[0], 'owner != msg.sender');
      })
    })
  });

  it("Should set the 'required' field", function() {
    return MultiSig.deployed(2)

    .then(function(instance) {
      var required;
      instance.required.call()

      .then(function(response) {
        // console.log(response);
        required = response;
        assert.equal(required, 2, "'required' field not set");
      });
    });
  });

  it("Should add a member", function() {
    return MultiSig.deployed(2)

    .then(function(instance) {
      var memberCount = 0;
      instance.addMember(accounts[0], 'Alex')

      .then(function(response) {
        // console.log(response);
        memberCount = response + 1;
        assert.equal(memberCount, 1, "Did not addMember");
      });
    });
  });

});

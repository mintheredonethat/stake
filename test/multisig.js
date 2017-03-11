var MultiSig = artifacts.require("./MultiSig.sol");

contract('MultiSig', function(accounts) {
  it("Should assign owner of contract as msg.sender", function() {
    return MultiSig.deployed(2, {from: accounts[0]})

    .then(function(instance) {
      var owner;
      var required;
      return instance.owner.call()

      .then(function(response) {
        owner = response;
        assert.equal(owner, accounts[0], 'owner != msg.sender');
      })
    })
  });

  it("Should set the 'required' field", function() {
    return MultiSig.deployed(2)

    .then(function(instance) {
      var required;
      return instance.required.call()

      .then(function(response) {
        required = response;
        assert.equal(required, 2, "'required' field not set");
      });
    });
  });

  it("Should add a member & test functions: getMemberCount, getMember", function() {
    return MultiSig.deployed(2)

    .then(function(instance) {
      var memberCount;
      return instance.addMember(accounts[0], 'Alex')

      .then(function(response) {
        return instance.getMemberCount()

        .then(function(response) {
          memberCount = response;
          console.log(`MembeCount: ${memberCount}`)
          assert.equal(memberCount, 1, "Did not addMember");

          return instance.getMember(accounts[0])

          .then(function(response) {
            // console.log(web3.toAscii(response[0]));
            console.log(response);
            assert.equal(response[1], 0, 'Did not get');
          })
        })
      });
    });
  });

});

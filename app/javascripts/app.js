// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3 } from 'web3';
import { default as contract } from 'truffle-contract';

// Import our contract artifacts and turn them into usable abstractions.
import stakeOne_artifacts from '../../build/contracts/StakeOne.json';

// NameRegistry is our usable abstraction, which we'll use through the code below.
var StakeOne = contract(stakeOne_artifacts);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;

window.App = {
  start: function() {
    console.log(`---------- start() ----------`);
    var self = this;

    // Bootstrap the MetaCoin abstraction for Use.
    // NameRegistry.setProvider(web3.currentProvider);
    StakeOne.setProvider(web3.currentProvider);

    // Get the initial account balance so it can be displayed.
    web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        alert("There was an error fetching your accounts.");
        return;
      }

      if (accs.length == 0) {
        alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }

      accounts = accs;
      account = accounts[0];
      // self.refreshRegistry();
      self.getBalance();
      self.getCurrentWithdrawal();
      self.getConfirmations();
      self.getRequired();
    });
  },

  getBalance: function() {
    var self = this;
    var balanceHolder = document.getElementById("balance");

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- getBalance() ----------`);
      return instance.getBalance();
    })
    .then(function(balance) {
      console.log(`Balance updated: ${balance}`);
      balanceHolder.innerHTML = web3.fromWei(balance);
      return balance;
    })
    .catch(function(error) {
      console.log(`Balance not updated: ${error}`);
    })
  },

  setStatus: function(message) {
    console.log(`---------- setStatus() ----------`);
    var status = document.getElementById("status");
    status.innerHTML = message;
  },

  getMembers: function() {
    var self = this;
    this.setStatus("Getting all members");

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- getMembers() ----------`);
      return instance.getMembers()
    })
    .then(function(data) {
      var names = String(data[0]).split(',');
      var addresses = String(data[1]).split(',');
      var tableRows = [];

      for (var i = 0; i < names.length; i++) {
        tableRows.push(web3.toAscii(names[i]));
        tableRows.push(addresses[i]);
      }

      self.setStatus(
        tableRows
      );
    })
  },

  register: function() {
    var self = this;
    var name = document.getElementById("name").value;
    var address = document.getElementById("address").value;

    this.setStatus("Registering Name/Address Pair...");

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- register() ----------`);
      return instance.registerMember(name, address, {from: account});
    })
    .then(function() {
      console.log("Successfully registered member");
      self.getRequired();
    })
    .catch(function(e) {
      console.log(`Failed to register member: ${e}`);
    })
  },

  depositStake: function() {
    var self = this;
    var deposit = document.getElementById("deposit").value;

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- depositStake() ----------`);
      return instance.depositStake({from: account, value: web3.toWei(deposit)});
    })
    .then(function(result) {
      console.log("Successfully deposited... now refreshing balance");
      self.getBalance();
    })
    .catch(function(error) {
      console.log(`Failed to deposit: ${error}`);
    })
  },

  getCurrentWithdrawal: function() {
    var self = this;
    var currentWithdrawalHolder = document.getElementById("current-withdrawal");

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- getCurrentWithdrawal() ----------`);
      return instance.getCurrentWithdrawal({from: account});
    })
    .then(function(withdrawal) {
      console.log(`Successfully got current withdrawal: ${withdrawal}`);
      currentWithdrawalHolder.innerHTML = withdrawal[0];
    })
    .catch(function(error) {
      console.log(`Failed to get current withdrawal: ${error}`)
    })
  },

  getRequired: function() {
    var self = this;
    var requiredHolder = document.getElementById("required");

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- getRequired() ----------`);
      instance.required();
    })
    .then(function(result) {
      console.log(`Successfully got required count: ${result}`);
      requiredHolder.innerHTML = result;
    })
    .catch(function(error) {
      console.log(`Failed to get required count: ${error}`);
    })
  },

  getConfirmations: function() {
    var self = this;
    var confirmationsHolder = document.getElementById("num-confirm");

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- getConfirmations() ----------`);
      return instance.getCurrentWithdrawal();
    })
    .then(function(withdrawal) {
      console.log(`Successfully got withdrawal confirmations count: ${withdrawal}`);
      confirmationsHolder.innerHTML = withdrawal[3];
    })
    .catch(function(error) {
      console.log(`Failed to get withdrawal in getConfirmations(): ${error}`);
    })
  },

  proposeWithdrawal: function() {
    var self = this;
    var recipient = document.getElementById("recipient").value;
    var amount = document.getElementById("amount").value;

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- proposeWithdrawal() ----------`);
      return instance.proposeWithdrawal(recipient, web3.toWei(amount), {from: account});
    })
    .then(function(result) {
      console.log(`Successfully proposed withdrawal: ${result}`);
      return self.getCurrentWithdrawal();
    })
    .then(function(result) {
      console.log(`Successfully proposed & getCurrentWithdrawal: ${result}`);
    })
    .catch(function(error) {
      console.log(`Successfully proposed, but didn't get current withdrawal: ${error}`);
    })
  },

  confirmWithdrawal: function() {
    var self = this;

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- confirmWithdrawal() ----------`);
      return instance.confirmWithdrawal({from: account});
    })
    .then(function(result) {
      console.log(`Successfully confirmed withdrawal: ${result}`);
      self.getConfirmations();
    })
    .then(function(confirmations) {
      console.log(`Successfully got num confirms after confirmWithdrawal(): ${confirmations}`);
    })
  },

  executeWithdrawal: function() {
    var self = this;

    StakeOne.deployed()
    .then(function(instance) {
      console.log(`---------- executeWithdrawal() ----------`);
      return instance.executeWithdrawal({from: account});
    })
    .then(function(result) {
      console.log(`Successfully executed withdrawal: ${result}`);
      self.getBalance();
    })
    .then(function(balance) {
      console.log(`Successfully got balance: ${balance}`);
    })
    // .catch(function(error) {
    //   self.setStatus("Failed execution of withdrawal - check log");
    //   console.log(error);
    // })
  }

};

window.addEventListener('load', function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }

  App.start();
});

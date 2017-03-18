# Stake

Inception: 03.08.17

Stake holds you and your team accountable to achieving your goals.

By placing a stake into a contract, the only way to recoup your ether is to meet your goals & have your teammates validate your progress.

Stake is developed through the Truffle framework, and leverages name registry and multi-signature capabilities via smart contract.

+++ INSERT GIF OF USAGE +++

## Motivation for Stake

Self-awareness enlightened me to my subtle form of procrastination - I would learn a lot by digesting material, but never really applied what I learned.
By "being in motion" as opposed to "taking action" ([James Clear](http://jamesclear.com/taking-action)), I was no closer to achieving my goals than I was X days ago.

I sought out peers to hold me accountable to completing my tasks.
When we meet, we peer-assess our progress and discuss goals for the coming week.
Each person deconstructs their goals into measurable, actionable units.
In order to pass the week, you need evidence of progress (complete X units of goal Y).
If you fail to meet your goals, you are "punished" for not doing so.

For example, I would send X ether to the contract.
Complete weekly tasks? Initiate a withdrawal process, and upon team confirmation, I can be refunded my ether.
Did not complete? Team would not consent to withdrawal, and I would not be able to recoup my stake; stake stays in team contract.

One of my goals this week (03.06.17 - 03.12.17) was to *_really_* learn solidity & dapp development by "taking action".
I wanted to build an app for my accountability group using smart contracts.
Initially, I looked at implementations of name registries & multi-sig wallets.
Though I grasped some of the code, there were many concepts that flew over my head.
Copying & pasting doesn't really help me learn - I spiked some of their core concepts instead.
I decided to start small & build up the features I needed, thereby expanding my working knowledge.
As of 03.12.17, I have formed the barebones foundation; I've met one of my goals for the week.

I am learning a lot & regularly document my progress and code.
I hope novices, who are in my position, can learn from this repo; I felt many of the public tutorials were either too simplistic or complex.
Also, I hope people will use this platform (once complete) to achieve their goals & realise a potential previously deemed inaccessible.

I appreciate any feedback & contributions - thank you in advance.

Here's to taking action, getting things done, and raising the bar.

## Learning Goals of Stake

* Comfort with solidity & truffle
* Develop UI for contracts
* Contract Testing
* Event Logging
* Interaction between many contracts (import, deploy) - CMC/doug?
  * [Monax: Modular Solidity Tutorial 5](https://monax.io/docs/tutorials/solidity/solidity_5_modular_solidity/)

## Learn as Dev

Important Files
* contracts/StakeOne.sol
  * StakeOne, registerMember, getMembers, changeRequirement, depositStake, getBalance, getCurrentWithdrawal, proposeWithdrawal, confirmWithdrawal, executeWithdrawal
* test/TestStakeOne.js
* app/javascripts/app.js
* migrations/2_deploy_contracts.js

Run
* `npm i`
* `testrpc`
* `rm -rf build/ && truffle compile && truffle migrate && truffle console`
* `npm run dev`

Test
* `testrpc`
* `truffle test ./test/JS_FILE`

## General To Do

Contracts
* Break up monolith contract & modularise w/ TDD
  * 5 types model or action-driven architecture? (Monax)
  * import utility, set dependencies/deployment correctly
* Encapsulation (coupling, private)
* Current implementation enables DoS attack by never reaching required confirmations
  * [Ethereum Alarm Clock](http://www.ethereum-alarm-clock.com/)
* Many recurrent withdrawals vs. using finite state machine to manage one?
* Oraclise through Google Spreadsheets?

UI
* React?
* Authenticate via MetaMask
* Update table on successful registry
* Show currentWithdrawal
* Aesthetics

Testing
* Call vs. TXs
* Leverage events to debug & log testing process
  * [Solidity Docs: Events](https://solidity.readthedocs.io/en/develop/contracts.html#events)
* Usage of "contracts()" ("description" a la truffle - clean slate)
* [Truffle Docs: JS Tests](http://truffleframework.com/docs/getting_started/javascript-tests)
* [Consensys: Noob 101 Medium Post ](https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4#.e7p14uzfv)

## 03.18.17

Tasks Completed
* Update contract so register via owner or member (memberOrOwner modifier)
* Update deployment, run script that:
  * Sends Ether to MM address (hardcoded)
  * Registers MM address (hardcoded) from testrpc accounts[0] (owner)
  * [Truffle Docs: Deployment](http://truffleframework.com/docs/getting_started/migrations#deployer-deploy-contract-args-options-)
* Update testing, use promises

Learned
* Customisation of deployment using promises
* Test using promises (returns; no callback hell/nesting)

Questions
* When running tests, do the contracts get compiled & migrated, as per instructions dictated in the deployment?
* How to leverage events in testing? Where does the event logging show up in `truffle test`?
* How to listen for events to trigger functions in app.js?

To Do
* Show currentWithdrawal at top of UI
* Update contract commenting
* Finish testing all functions
  * Towards the end of the initial contract (03.12.17), I neglected TDD
* Contract factory for teams

Bugs
* executeWithdrawal() (in app.js; from truffle console is OK)
* Registering a member before currentState = 0
  * Will requirementChanged affect confirmation & state?
* getMembers() - format as table

## 03.16.17

Tasks Completed
* Updated gitignore & moved ignored files into ignored directory
* Leverage inheritance to make StakeOne contract Mortal (owned, onlyOwner, kill)

Learned
* Git pull ? `npm i` : (*facepalm*)
* Inheritance
  * A.sol
    * Import "path_to_file"
    * contract A is B {}
  * When migrating A, Truffle knows to automatically include B

To Do
* Split into NameReg & MultiSig, but ensure compatibility
* Callback Hell (Tests) --- _Updated 03.18.17_
* Pre & post modifiers
  * Implement a test contract (.sol)
  * [Androlo: Contract Oriented Programming](https://github.com/androlo/solidity-workshop/blob/master/tutorials/2016-07-02-contract-oriented-programming-II.md)
* Encapsulations (private/public)

## Lessons Learned (Before 03.16.17)
* Mapping pros & cons
  * KV store
  * Can't iterate easily
  * Mapping vs. Array
* Easy contract interaction via abstraction
  * No more hard coding address & ABI
* Running app within window.App & using window.web3
* web3.toAscii(bytes32)
* Deployment can take arguments; useful for contract constructors
* Testing: return something, .then()
  * [Chai: JS Tests](http://chaijs.com/api/assert/)
  * TDD should guide & verify development
  * Use console for quick checks
* Sending message (not TX) from contract to EOA (send ether)
* Monolith arises quickly
  * Learn to modularize contracts
  * Design before implementation - in this case, I wanted to learn by doing, was not focused on scalability
* Many ways to implement contracts
  * NameReg, Multi-sig, etc.
  * **Crucial to define scope & requirements** of users
* Exposed to many new concepts
  * Learn by doing
  * Find circle of competence & spiral outward from there
  * Trouble implementing? Google, docs, community
    * Should have a clear vision of what you want to implement
* Design decisions
  * Choosing a data structure over another (cost-benefit analysis)
  * Contracts are expensive! Ethereum is built for redundancy - keep only core code in contracts
* Finite state machine
* Deploys from web3.eth.accounts[0] automatically

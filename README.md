# Stake (Active Development: 03.08.17 - Present)

  Stake holds you and your team accountable to achieving your goals. By placing a stake into a contract, the only way to recoup your ether is to meet your goals & have your teammates validate your progress. Stake is developed through the Truffle framework, and leverages name registry and multi-signature capabilities via smart contract.

  +++ GIF OF USAGE +++

  +++ EXAMPLE SPREADSHEET OF GOALS +++

## Motivation for Stake

  It took self-awareness to realise my subtle form of procrastination.
  By "being in motion" as opposed to "taking action" ([James Clear](http://jamesclear.com/taking-action)), I was no closer to achieving my goals than I was X days ago.
  I *really* wanted to learn dapp development, and felt that building a dapp that would stop me from procrastinating would be a great way to do so.

  I formed an accountability group with my peers.
  Every week, we:
  * Set measurable goals for the coming week.
  * Set a stake for the coming week
  * Assess each others' progress
    * Facilitate peer assessment by providing evidence of your progress.
    * Failed the assessment? Punishment

  E.g., I state my goals, send X ether to a smart contract, complete my tasks by the end of the week, and:
  * Initiate a withdrawal process, and upon peer assessment/confirmation, I can be refunded my stake
  * Otherwise, I can't recoup my stake (team would not consent to withdrawal)

  I initially approached development by looking at multi-sig wallets & found that the implementations were either too simplistic or too complex.
  I decided to start small & build up the features I needed, thereby expanding my working knowledge.
  I'm regularly documenting my progress so that novices, like me, can learn from this repo without having to spend time with trial & error.

  I believe this platform will help people achieve their goals & realise a potential previously deemed inaccessible.
  I appreciate any feedback & contributions - thank you in advance.

  *Here's to taking action, getting things done, and raising the bar.*

## Initial Learning Goals of Stake

  * Comfort with solidity & truffle
  * Develop UI for contracts
  * Contract Testing
  * Event Logging
  * Multi contract interaction

## Developers:

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
    * import/inherit from utility contracts, set dependencies/deployment correctly
    * CMC Doug? [Monax 1: 5 Types](https://monax.io/docs/tutorials/solidity/solidity_1_the_five_types_model/)
    * [Monax 2: Action Driven Architecture](https://monax.io/docs/tutorials/solidity/solidity_2_action_driven_architecture)
    * [Monax 5: Modular Solidity](https://monax.io/docs/tutorials/solidity/solidity_5_modular_solidity/)
  * Encapsulation (coupling, private)
  * Current implementation enables DoS attack by never reaching required confirmations
    * [Ethereum Alarm Clock](http://www.ethereum-alarm-clock.com/)
  * Many recurrent withdrawals vs. using finite state machine to manage one?
    * Assumes contract interaction during team meeting
  * Oraclise through Google Spreadsheets?

  UI
  * React?
    * Update table on successful registry
  * Authenticate via MetaMask
  * Show currentWithdrawal
  * Aesthetics

  Testing
  * Call vs. TXs
  * Leverage events to debug & log testing process
    * [Solidity Docs: Events](https://solidity.readthedocs.io/en/develop/contracts.html#events)
  * Usage of "contracts()" ("description" à la truffle - clean slate)
  * [Truffle Docs: JS Tests](http://truffleframework.com/docs/getting_started/javascript-tests)
  * [Consensys Blog: Noob 101](https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4#.e7p14uzfv)

## 03.19.17

  Completed
  * Include more tests for multi-sig functionality

  Learned
  * [Consensys Blog: Intro to Events & Logs](https://media.consensys.net/technical-introduction-to-events-and-logs-in-ethereum-a074d65dd61e#.80bgdzgm8)
    * Return Value for FrontEnd UI
    * Async Triggers w/ Data
    * Cheaper Form of Storage
  * [Truffle Docs: Interacting w/ Contracts - Events](http://truffleframework.com/docs/getting_started/contracts#catching-events)

  Questions
  * How to run tests w/o having to restart testrpc?

  Next
  * Test edge cases (states & requirements & registry & numConfirm)
  * Implement **event watchers** in tests & frontend
  * Gas optimisation (so expensive to propose, confirm, execute)
  * Seems that changing requirement should also go through confirmation process
  * **Re-architect platform**

## 03.18.17

  Completed
  * Updated contract registerMember function w/ memberOrOwner modifier
  * Changed deployment to:
    * Send Ether to MM address (hardcoded)
    * Register MM address (hardcoded) from testrpc accounts[0] (owner)
    * [Truffle Docs: Deployment](http://truffleframework.com/docs/getting_started/migrations#deployer-deploy-contract-args-options-)
  * Updated testing to use promises

  Learned
  * Customisation of deployment using promises
  * Test using promises (return - no callback hell/nesting)

  Questions
  * When running tests, do the contracts get deployed based on 2_deploy_contracts?

  Next
  * Show currentWithdrawal at top of UI --- _Updated 03.19.17_
  * Update contract commenting
  * **Finish testing all functions**
  * Contract factory for teams
  * getMembers() - format as table
  * **Bug: executeWithdrawal()** (app.js broken; truffle console ok)

## 03.16.17

  Tasks Completed
  * Updated gitignore w/ ignore directory
  * StakeOne inherits from Mortal (owned, onlyOwner, kill)

  Learned
  * Git pull ? `npm i` : (*facepalm*)
  * Inheritance (if A.sol)
    * Import "path_to_file"
    * contract A is B {}
    * Migrating A? Truffle automatically includes B

  Next
  * Split into NameReg & MultiSig, but ensure compatibility
  * Callback Hell (Tests) --- _Updated 03.18.17_
  * Pre & post modifiers
    * Implement a test contract (.sol) - [Androlo: Contract Oriented Programming (COP)](https://github.com/androlo/solidity-workshop/blob/master/tutorials/2016-07-02-contract-oriented-programming-II.md)
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

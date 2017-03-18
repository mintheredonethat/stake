# Stake

Inception: 03.08.17

Stake holds you and your team accountable to achieving your goals.

By placing a stake into a contract, the only way to recoup your ether is to meet your goals & have your teammates validate your progress.

Stake is developed through the Truffle framework, and leverages name registry and multi-signature capabilities via smart contract.

+++ INSERT GIF OF USAGE +++

## Motivation for Stake

Self-awareness enlightened me to my subtle form of procrastination - I would learn a lot by digesting material, but never really applied what I learned.
By "being in motion" as opposed to "taking action" ([James Clear](http://jamesclear.com/taking-action)), I was no closer to achieving my goals than I was X days ago.

I sought out accountability buddies to make sure I would complete my tasks.
Each person in the team deconstructed their goals into measurable, actionable units.
This makes it easier to track progress & fairly assess other teammates.
Each week, we convene & discuss our goals for the week, as well as assess how the previous week had gone.
In order to pass the week, you have to show evidence of progress for each goal (complete X units of Y).
If you did not meet your goals, you would be "punished" for not doing so.
For example, I would place X ether in escrow.
If I complete my tasks, I initiate a withdrawal process, where I can be refunded my ether if the rest of team confirms my progress & my withdrawal.
If I did not complete my tasks, I would not be able to recoup that ether - my teammates would not consent to withdrawal; the ether would instead be devoted to a team pot.

One of my goals this past week (03.06.17 - 03.12.17) was to *really* learn solidity & dapp development by "taking action".
I wanted to build the basis (with smart contracts) to make this group accountability process easier.
Initially, I looked at implementations of name registries & multi-sig wallets.
Though I grasped some of the code, there were many concepts that flew over my head.
Copying & pasting doesn't really help me learn - I spiked some of their core concepts instead.
I decided to start small & build up the features I needed, increasing my working knowledge.
As of 03.12.17, I have finished the barebones implementation - I've met one of my goals for the week :)
Cheers

I learned a lot throughout this journey and tried regularly documenting my process & code.
I hope novice smart contract & dapp developers can learn from this repo, as many of the tutorials out there were for me either too simplistic or too complex.
Additionally, I hope people will use this platform (once complete) to achieve their goals & realise a potential previously deemed inaccessible.

Here's to taking action, getting things done, and raising the bar.

## Learning Goals of Stake

* Comfort with solidity & truffle
* Develop UI for contracts
* Contract Testing
* Event Logging
* Interaction between many contracts (import, deploy) - CMC/doug?
  * [Monax Tutorials: Modular Solidity](https://monax.io/docs/tutorials/solidity/solidity_5_modular_solidity/)
* Contract factory for different teams

## Learn as Dev

Contracts
* contracts/StakeOne.sol
* test/TestStakeOne.js

Commands
* `npm i`
* `testrpc`
* `rm -rf build/ && truffle compile && truffle migrate && truffle console`
* `npm run dev`
* `truffle test ./test/JS_FILE`

I appreciate any feedback & contributions - thank you in advance.

## To Do

Contracts
* Break up monolith contract & modularise w/ TDD (avoid callback hell w/ promises)
  * 5 types model or action-driven architecture?
  * import utility, set dependencies/deployment correctly
* Encapsulation (coupling, private)
* Current implementation enables DoS attack by never reaching required confirmations
  * [Ethereum Alarm Clock](http://www.ethereum-alarm-clock.com/)
* Many recurrent withdrawals vs. using finite state machine to manage one?
* Oraclise through Google Spreadsheets?

UI
* Implement one... lol
  * React?
* Authenticate via MetaMask
* Update table on successful registry
* Show currentWithdrawal
* Aesthetics

Testing
* Less nesting & callback hell!!! PROMISES/returns & pudding?
* Check if I'm CALLing at the correct places, not making TXs accidentally
* Leverage events to debug & log testing process
* Make use of beforeEach?
* More usage of "contracts()" (truffle version of description)
* [Truffle Docs: JS Tests](http://truffleframework.com/docs/getting_started/javascript-tests)
* [Consensys Noob 101 Medium Post ](https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4#.e7p14uzfv)
* [Solidity Docs: Events](https://solidity.readthedocs.io/en/develop/contracts.html#events)

Scripting
* Auto-set accounts
  * var acct1 = web3.eth.accounts[0]

## 03.18.17

Tasks Completed
* Update contract so register via owner or member (memberOrOwner modifier)
* Update deployment, run script that:
  * Sends Ether to MM address (hardcoded)
  * Registers MM address (hardcoded) from testrpc accounts[0] (owner)
  * [Truffle Docs: Deployment](http://truffleframework.com/docs/getting_started/migrations#deployer-deploy-contract-args-options-)

Learned
* How to customise deployment using promises

To Do
* Show currentWithdrawal at top of UI
* Update contract commenting
* Contract factory for teams

## 03.16.17

Tasks Completed
* Updated gitignore & moved ignored files into ignored directory
* Leverage inheritance to make StakeOne contract Mortal (owned, onlyOwner, kill)

Learned
* Git pull? Don't forget to `npm i` (*facepalm*)
* Inheritance
  * Import "path_to_file"
  * contract A is B {}

Questions
* In StakeOne.sol, I import from Mortal & state StakeOne is Mortal
  * When migrating StakeOne.sol, does truffle know to automatically include Mortal.sol?
    * Yes, it does.

To Do
* Split into NameReg & MultiSig, but ensure compatibility
* Callback Hell (Tests)
* Pre & post modifiers
  * Test contract
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
  * [Chai JS Tests](http://chaijs.com/api/assert/)
  * TDD should guide & verify development
  * Use console for quick checks
* Sending message from contract to EOA (send ether)
* Monolith arises quickly
  * Learn to modularize contracts
  * Design before implementation - in this case, I wanted to learn by doing, was not focused on scalability
* Many ways to implement contracts
  * NameReg
  * Multi-sig
  * CRUCIAL TO DEFINE SCOPE & REQUIREMENTS of users
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

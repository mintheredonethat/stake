# Stake

Inception: 03.08.17

Stake holds you and your team accountable to achieving your goals.

By placing a stake into a contract, the only way to recoup your ether is to meet your goals & have your teammates validate your progress.

Stake was developed through the Truffle framework, leveraging name registry and multi-signature capabilities via smart contract.

## Story

Self-awareness enlightened me to my subtle procrastination - I would learn a lot by digesting material, but never really applied what I learned.
By "being in motion" as opposed to "taking action", I was no closer to achieving my goals than I was X days ago.

I sought out accountability buddies to make sure I would complete my tasks.
We split our tasks into measurable units, so that we could track our progress & be fairly assessed by everyone in the group.
Each week, we convene & discuss our goals for the week, as well as assess how the previous week had gone.
In order to pass the week, you have to show measurable progress for each task (complete X units of Y).
If we did not meet our goals, we would be "punished" for not doing so.
For example, I would place X ether in escrow.
If I did not complete my tasks, I would not be able to recoup that ether.
It would instead be devoted to a team pot.

One of my goals this past week was to learn dapp development for real.
I wanted to build the basis to make my group accountability process easier.
I thought that smart contracts would be a great way to do so.
Today, I have finished the barebones implementation - I've met one of my goals for the week :)
Cheers, accountabili-buddies.

## Overview

My technical goal of this project was to learn more about Solidity & dapp development by "taking action".
Initially, I looked at implementations of name registries & multi-sig wallets.
Though I grasped some of the code, there were many concepts that flew over my head.
Copying & pasting doesn't really help me learn.
I decided to start small & build up the features I needed, increasing my working knowledge.
I learned a lot throughout the process, and tried documenting my journey & code, though I'd often forget to.
I hope novice smart contract & dapp developers can learn from this, as many of the contracts out there are either too basic or complex.
Additionally, I hope people will use this platform to achieve their goals & realise a potential previously deemed inaccessible.

## Current

I implemented the foundations for a confirmation-based wallet that keeps track of users' addresses & names in a registry.
I realise my contract is quite monolithic & would like to improve it through modularisation & gas optimisation.
I appreciate any feedback & contributions - thank you in advance.

INSERT GIF OF USAGE

RENAME REPO

## Learn as Dev
* `rm -rf build/`
* `testrpc`
* `truffle compile && truffle migrate && truffle console`
* `npm run dev`
* `truffle test ./test/multisig.js`

## Learning Goals of Stake
* Comfort with solidity & truffle
* Develop UI for contracts
* Contract Testing
* Event Logging
* Interaction between many contracts (import, deploy) - CMC/doug?

## To Do

Contracts
* Modularise, split up monolithic structure
* Utility contract? For modifiers & common functions
* Current implementation enables DoS attack by never reaching required confirmations
  * Timer?
* Oraclise through Google Spreadsheets? Overkill?
* Many recurrent withdrawals vs. using finite state machine to manage one?

UI
* Update table on successful registry
* Aesthetics
* Encourage users to use MetaMask

Testing
* Leverage events to debug & log testing process
* Check if I'm CALLing at the correct places, not making TXs accidentally
* Less nesting!!! PROMISES/returns & pudding?
* Make use of beforeEach?
* More usage of "contracts()" (truffle version of description)
* http://truffleframework.com/docs/getting_started/javascript-tests
* https://medium.com/@ConsenSys/a-101-noob-intro-to-programming-smart-contracts-on-ethereum-695d15c1dab4#.e7p14uzfv
* https://solidity.readthedocs.io/en/develop/contracts.html#events

Scripting
* Auto-set accounts
  * var acct1 = web3.eth.accounts[0]
* Send ETH to testnet address on MetaMask from local testrpc address
  * web3.eth.sendTransaction({ from: acct1, value: web3.toWei(20, 'ether'), to: MM_ADDRESS })

## Lessons Learned
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
  * http://chaijs.com/api/assert/
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

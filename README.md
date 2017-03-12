# Stake

Inception: 03.08.17

Get things done with Stake - holds you & your team accountable to meeting your goals.

Developed via Truffle; leverages smart contracts:
* Name registry
* Multi-signature wallet

INSERT GIF OF USAGE

## How To Run
* `testrpc` (new window)
* `truffle compile && truffle migrate && truffle console` (new window)
* `npm run dev` (new window)

* `truffle test ./test/multisig.js`

## Learning Goals of Stake
* Comfort with solidity & truffle
* Develop UI for contracts
* Implement tests for contracts
* Multiple contracts' interacting with each other

## To Do

Name Reg Contract
* Add fallback
* onlyOwner modifier?
* Iterate over mapping to create table of addresses x names

Multi-sig Wallet
* Finite state (enum) allows for certain functions

UI
* Update table on successful registry
* Leverage contract's emitted events
* Aesthetics

Testing
* Description, It, Asserts

Script
* Auto-sets accounts
  * var acct1 = web3.eth.accounts[0]
* Send ETH to testnet address on MetaMask from local testrpc address
  * web3.eth.sendTransaction({ from: acct1, value: web3.toWei(20, 'ether'), to: MM_ADDRESS })

## Lessons Learned
* Mapping pros & cons
  * KV store
  * Can't iterate easily
* Easy contract interaction via abstraction
  * No more hard coding address & ABI
* Running app within window.App & using window.web3
* web3.toAscii(bytes32)
* Deployment can take arguments, for contract constructors



# Ignore Below - Truffle Notes...

### truffle-init-webpack
Example webpack project with Truffle. Includes contracts, migrations, tests, user interface and webpack build pipeline.

#### Usage

To initialize a project with this exapmple, run `truffle init webpack` inside an empty directory.

#### Building and the frontend

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080

#### Possible upgrades

* Use the webpack hotloader to sense when contracts or javascript have been recompiled and rebuild the application. Contributions welcome!

#### Common Errors

* **Error: Can't resolve '../build/contracts/MetaCoin.json'**

This means you haven't compiled or migrated your contracts yet. Run `truffle compile` and `truffle migrate` first.

Full error:

```
ERROR in ./app/main.js
Module not found: Error: Can't resolve '../build/contracts/MetaCoin.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'
 @ ./app/main.js 11:16-59
```

# Name Registry smart contract using Truffle framework

03.08.17

Basic name registry contract with a front-end. Forms the basis of the Stake platform.

INSERT SCREENSHOT/GIF OF USAGE

## How To Run
* `truffle compile` (one window)
* `testrpc` (another window)
* `truffle migrate`
* `npm run dev`
* `truffle console` (another window)

## Goals
* Comfort with solidity & truffle
* Develop UI for contract
* Implement tests for contract

## To Do

Contract
* Add fallback
* onlyOwner modifier?

UI
* Iterate over mapping to create table of addresses x names
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

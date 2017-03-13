# Stake

Inception: 03.08.17

Get things done with Stake - be accountable to achieving your goals.

Developed via Truffle; leverages smart contracts:
* Name registry
* Multi-signature wallet

INSERT GIF OF USAGE

## Learn as Dev
* `testrpc`
* `truffle compile && truffle migrate && truffle console`
* `npm run dev`
* `truffle test ./test/multisig.js`

## Learning Goals of Stake
* Comfort with solidity & truffle
* Develop UI for contracts
* Contract Testing
* Interaction between many contracts (import, deploy)
* Event Logging

## To Do

Contracts
* Modularize, split up monolithic structure
* Utility contract? For modifiers & common functions
* Events
* Current implementation enables DoS attack by never reaching required confirmations (timer)

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
* Testing: return something, .then()
* http://chaijs.com/api/assert/



# Ignore Below - Truffle Notes...

#### truffle-init-webpack
Example webpack project with Truffle. Includes contracts, migrations, tests, user interface and webpack build pipeline.

##### Usage

To initialize a project with this exapmple, run `truffle init webpack` inside an empty directory.

##### Building and the frontend

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080

##### Possible upgrades

* Use the webpack hotloader to sense when contracts or javascript have been recompiled and rebuild the application. Contributions welcome!

##### Common Errors

* **Error: Can't resolve '../build/contracts/MetaCoin.json'**

This means you haven't compiled or migrated your contracts yet. Run `truffle compile` and `truffle migrate` first.

Full error:

```
ERROR in ./app/main.js
Module not found: Error: Can't resolve '../build/contracts/MetaCoin.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'
 @ ./app/main.js 11:16-59
```

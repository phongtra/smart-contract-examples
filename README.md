# smart-contract-examples

**Smart contract example**

This is a smart contract inspired by CryptoZombie. Go to https://cryptozombies.io/en/course for more details

The purpose of this contract is to create a zombie game where a player can create one random zombie, attack kitties, and attack other player's zombie. There is a cooldown time so they cannot just attack all the time.

**To run**

Clone the project, and run `npm install`

To compile, run `truffle compile`

After that, run `truffle migrate` and it will deploy to your own network. To deploy to Rinkeby testnet, run `truffle migrate --network rinkeby`

To test, run `truffle test`

Make sure you have your own mnemonic and token if you want to deploy to Rinkeby.

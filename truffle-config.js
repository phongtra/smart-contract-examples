var HDWalletProvider = require('truffle-hdwallet-provider');
var keys = require('./keys');
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*' // Match any network id
    },
    develop: {
      port: 8545
    },
    rinkeby: {
      // Special function to setup the provider
      provider: function() {
        // Setting the provider with the Infura Rinkeby address and Token
        return new HDWalletProvider(
          keys.mnemonic,
          `https://rinkeby.infura.io/v3/${keys.token}`
        );
      },
      // Network id is 4 for Rinkeby
      network_id: 4
    }
  }
};

var CryptoZombie = artifacts.require('./CryptoZombie.sol');
module.exports = function(deployer) {
  deployer.deploy(CryptoZombie);
};

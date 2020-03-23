pragma solidity >=0.4.21 <=0.7.0;
import "./ZombieHelper.sol";

contract ZombieAttack is ZombieHelper {
    uint256 randNonce = 0;
    uint256 attackVictoryProbability = 70;
    function attack(uint256 _zombieId, uint256 _targetId)
        external
        onlyOwnerOf(_zombieId)
    {
        require(
            zombieToOwner[_targetId] != msg.sender,
            "Cannot attack your own zombie"
        );
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint256 rand = randMod(100);
        if (rand <= attackVictoryProbability) {
            myZombie.winCount.add(1);
            myZombie.level.add(1);
            enemyZombie.lossCount.add(1);
            _feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount.add(1);
            enemyZombie.winCount.add(1);
            _triggerCooldown(myZombie);
        }
    }
    function randMod(uint256 _modulus) internal view returns (uint256) {
        randNonce.add(1);
        return
            uint256(keccak256(abi.encodePacked(now, msg.sender, randNonce))) %
            _modulus;
    }

}

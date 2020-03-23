pragma solidity >=0.4.21 <=0.7.0;
import "./ZombieFactory.sol";

interface KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

contract ZombieFeeding is ZombieFactory {
    KittyInterface kittyContract;
    modifier onlyOwnerOf(uint256 _zombieId) {
        require(
            zombieToOwner[_zombieId] == msg.sender,
            "You must own the zombie"
        );
        _;
    }
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }
    function _feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) internal onlyOwnerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie), "Need more time");
        uint256 targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + targetDna) / 2;
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty"))
        ) {
            newDna = newDna - (newDna % 100) + 99;
        }
        _createZombie("No name", newDna);
        _triggerCooldown(myZombie);
    }
    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        _feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }
    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now);
    }
}

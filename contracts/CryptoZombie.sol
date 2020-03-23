pragma solidity >=0.4.21 <=0.7.0;
import "./ZombieOwnership.sol";

contract CryptoZombie is ZombieOwnership {
    function kill() public onlyOwner {
        selfdestruct(address(uint16(owner())));
    }
}

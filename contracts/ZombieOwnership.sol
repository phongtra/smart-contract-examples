pragma solidity >=0.4.21 <=0.7.0;
import "./ZombieAttack.sol";
import "./ERC21.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {
    mapping(uint256 => address) zombieApprovals;
    function balanceOf(address _owner) external view returns (uint256) {
        return ownerZombieCount[_owner];
    }
    function ownerOf(uint256 _tokenId) external view returns (address) {
        return zombieToOwner[_tokenId];
    }
    function transferFrom(address _from, address _to, uint256 _tokenId)
        external
        payable
    {
        require(
            zombieToOwner[_tokenId] == msg.sender ||
                zombieApprovals[_tokenId] == msg.sender,
            "Must be allowed to send"
        );
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId)
        external
        payable
        onlyOwnerOf(_tokenId)
    {
        zombieApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerZombieCount[_to].add(1);
        ownerZombieCount[_from].sub(1);
        zombieToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
}

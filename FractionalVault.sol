// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./NFTShares.sol";

contract FractionalVault is IERC721Receiver {
    NFTShares public immutable shards;
    IERC721 public immutable nftCollection;
    uint256 public immutable tokenId;
    
    bool public isFractionalized;
    uint256 public constant TOTAL_SHARDS = 1_000_000 * 10**18;

    constructor(address _nftCollection, uint256 _tokenId, string memory _name, string memory _symbol) {
        nftCollection = IERC721(_nftCollection);
        tokenId = _tokenId;
        shards = new NFTShares(_name, _symbol, address(this));
    }

    function fractionalize() external {
        require(!isFractionalized, "Already fractionalized");
        isFractionalized = true;

        nftCollection.safeTransferFrom(msg.sender, address(this), tokenId);
        shards.mint(msg.sender, TOTAL_SHARDS);
    }

    function redeem() external {
        require(isFractionalized, "Not fractionalized");
        require(shards.balanceOf(msg.sender) == TOTAL_SHARDS, "Must own all shards");

        shards.burn(msg.sender, TOTAL_SHARDS);
        isFractionalized = false;
        nftCollection.safeTransferFrom(address(this), msg.sender, tokenId);
    }

    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}

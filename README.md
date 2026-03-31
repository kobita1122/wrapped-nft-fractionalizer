# Wrapped NFT Fractionalizer

A professional-grade DeFi primitive for increasing NFT liquidity. This repository allows a high-value NFT to be "fractionalized" into fungible ERC-20 tokens (shards), enabling multiple users to own a percentage of the underlying digital asset.

## Core Features
* **Vault Storage:** Securely locks the ERC-721 token using `onERC721Received`.
* **Shard Issuance:** Mints a fixed supply of ERC-20 tokens representing ownership.
* **Redemption Logic:** Allows the NFT to be reclaimed if a user (or group) burns 100% of the shards.
* **Flat Structure:** All logic for the vault, the shard token, and the fractionalization process is in the root directory.

## Workflow
1. **Initialize:** Deploy the `FractionalVault` with the target NFT address and ID.
2. **Fractionalize:** Lock the NFT and mint 1,000,000 shards.
3. **Trade:** Shards can be traded on an AMM (like Uniswap).
4. **Redeem:** Burn the total supply of shards to unlock the NFT from the vault.

## Setup
1. `npm install`
2. Deploy `NFTShares.sol` and `FractionalVault.sol`.

# NFT Staking Reward Engine

This repository contains a robust, flat-structured implementation of an NFT Staking Vault. It is designed for projects looking to incentivize long-term holding of NFT collections.

## Core Logic
* **Stake/Unstake:** Users can transfer their NFTs to the vault.
* **Reward Calculation:** Rewards are accrued per block (or per second) based on the staking duration.
* **Yield Harvesting:** Users can claim earned tokens without unstaking their NFTs.

## Technical Highlights
* **Gas Efficiency:** Uses a mapping-based tracking system to minimize loop iterations.
* **Security:** Implements `onERC721Received` to ensure the contract can safely handle NFT transfers.

## Setup
1. Deploy the Reward Token (ERC-20).
2. Deploy this Staking Vault with the NFT and Token addresses.
3. Fund the Vault with Reward Tokens.

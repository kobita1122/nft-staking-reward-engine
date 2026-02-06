// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INFTStaking {
    struct Stake {
        uint240 tokenId;
        uint48 timestamp;
        address owner;
    }
}

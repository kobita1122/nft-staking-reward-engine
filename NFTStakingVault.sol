// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "./INFTStaking.sol";

contract NFTStakingVault is IERC721Receiver, INFTStaking {
    IERC721 public nftCollection;
    IERC20 public rewardToken;
    uint256 public rewardRatePerHour = 10 * 10**18;

    mapping(uint256 => Stake) public vault;

    constructor(address _nft, address _token) {
        nftCollection = IERC721(_nft);
        rewardToken = IERC20(_token);
    }

    function stake(uint256[] calldata tokenIds) external {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            nftCollection.safeTransferFrom(msg.sender, address(this), tokenIds[i]);
            vault[tokenIds[i]] = Stake(uint240(tokenIds[i]), uint48(block.timestamp), msg.sender);
        }
    }

    function unstake(uint256[] calldata tokenIds) external {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            Stake memory stakedItem = vault[tokenIds[i]];
            require(stakedItem.owner == msg.sender, "Not owner");
            
            uint256 reward = calculateReward(stakedItem.timestamp);
            delete vault[tokenIds[i]];
            
            rewardToken.transfer(msg.sender, reward);
            nftCollection.safeTransferFrom(address(this), msg.sender, tokenIds[i]);
        }
    }

    function calculateReward(uint256 timestamp) public view returns (uint256) {
        uint256 hoursStaked = (block.timestamp - timestamp) / 3600;
        return hoursStaked * rewardRatePerHour;
    }

    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}

// SPDX-License-Identifier: UNLICSENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract TwitterFeed {
    uint256 totalTweets;
    uint256 private seed;

    event NewTweet(address indexed from, string message, uint256 timestamp);

    // custom datatype
    struct Tweet {
        address from;
        string message;
        uint256 timestamp;
    }

    Tweet[] tweets;

    mapping(address => uint256) public lastTweetedAt;

    constructor() payable {
        console.log("Heyyy, I'am a smart contract - niceee");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function tweet(string memory _message) public {
        
         require(
             lastTweetedAt[msg.sender] + 60 seconds < block.timestamp,
            "Stop spamming, wait 60 seconds"
        );

        lastTweetedAt[msg.sender] = block.timestamp;


        totalTweets += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        tweets.push(Tweet(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if(seed <= 10) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.00001 ether;
            require(prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has");

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract");

        }

        emit NewTweet(msg.sender, _message, block.timestamp);
    }

    function getAllTweets() public view returns (Tweet[] memory) {
        return tweets;
    }

    function getTotalTweets() public view returns (uint256) {
        console.log("We have %d total waves!", totalTweets);
        return totalTweets;
    }
}
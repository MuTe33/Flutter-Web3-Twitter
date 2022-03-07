// SPDX-License-Identifier: UNLICSENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;

    event NewWave(address indexed from, string message, uint256 timestamp);

    // custom datatype
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Heyyy, I'am a smart contract - niceee");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

         require(
            lastWavedAt[msg.sender] + 60 seconds < block.timestamp,
            "Stop spamming, wait 60 seconds"
        );

        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if(seed <= 10) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.00001 ether;
            require(prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has");

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract");

        }

        emit NewWave(msg.sender, _message, block.timestamp);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
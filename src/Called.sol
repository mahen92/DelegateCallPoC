// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract Called {
    function getInfo() public payable returns (address, uint256, address) {
        console.log("first:", msg.sender);
        console.logBytes(msg.data);
        console.log("second:", address(this));
        return (msg.sender, msg.value, address(this));
    }
}

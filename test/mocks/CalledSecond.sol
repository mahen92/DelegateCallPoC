pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract CalledLast {
    function logSender() public {
        console.log("CalledSecond:", msg.sender);
    }
}

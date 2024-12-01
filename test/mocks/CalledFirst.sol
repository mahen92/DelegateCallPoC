pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract CalledFirst {
    function logSender(address calledLast, bool flag) public {
        console.log("CalledFirst:", msg.sender);

        if (flag) {
            calledLast.delegatecall(abi.encodeWithSignature("logSender()"));
        } else {
            calledLast.call(abi.encodeWithSignature("logSender()"));
        }
    }
}

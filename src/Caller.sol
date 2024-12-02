// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

/**
 * @title Delegate Call POC
 * @author Mahendran Anbarasan
 * @notice The contract is used to check and confirm how delegate call works with msg.sender,address(this),codesize() 
 * and two delegate calls.
 */
contract Caller {
    function getDelegatedInfo(address _called) public payable returns (address, uint256, address) {
        (bool success, bytes memory data) = _called.delegatecall(abi.encodeWithSignature("getInfo()"));
        (address first, uint256 number, address second) = abi.decode(data, (address, uint256, address));
        return abi.decode(data, (address, uint256, address));
    }

    function getDelegatedInformation(address _called) public payable returns (address, uint256, address) {
        (bool success, bytes memory data) = _called.delegatecall(abi.encodeWithSignature("getInformation()"));
        (address first, uint256 number, address second) = abi.decode(data, (address, uint256, address));
        return abi.decode(data, (address, uint256, address));
    }

    function getSizes(address _calledA, address _calledB) public returns (uint256 sizeA, uint256 sizeB) {
        (, bytes memory dataA) = _calledA.delegatecall(abi.encodeWithSignature("getCodeSize()"));
        (, bytes memory dataB) = _calledB.delegatecall(abi.encodeWithSignature("getCodeSize()"));

        sizeA = abi.decode(dataA, (uint256));
        sizeB = abi.decode(dataB, (uint256));

        console.log("sizeA:", sizeA);
        console.log("sizeB:", sizeB);
    }

    function delegateCallToFirst(address calledFirst, address calledSecond, bool flag1, bool flag2) public {
        if (flag1) {
            calledFirst.delegatecall(abi.encodeWithSignature("logSender(address,bool)", calledSecond, flag2));
        } else {
            calledFirst.call(abi.encodeWithSignature("logSender(address,bool)", calledSecond, flag2));
        }
    }
}

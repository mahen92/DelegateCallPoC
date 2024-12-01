// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Called.sol";
import "../src/Caller.sol";
import "./mocks/CalledA.sol";
import "./mocks/CalledB.sol";
import "./mocks/CalledFirst.sol";
import "./mocks/CalledSecond.sol";

/**
 * @title DelegateCall POC test file
 * @author Mahendran Anbarasan
 * @notice 
 */

contract DelegateTest is Test {
    Called public called;
    Caller public caller;
    address alice = makeAddr("alice");

    function setUp() public {
        called = new Called();
        caller = new Caller();
        console.log("***Setup****");
        console.log("alice:", alice);
        console.log("caller:", address(caller));
        console.log("called:", address(called));
        console.log("************");
    }

    /*Checks the values of msg.sender,codesize() during delegatecall*/
    function test_info() public {
        vm.startPrank(alice);
        caller.getDelegatedInfo(address(called));
        vm.stopPrank();
    }

    /*Checks the value of codesize() during delegatecall*/
    function test_sizes() public {
        vm.startPrank(alice);
        CalledA calledA = new CalledA();
        CalledB calledB = new CalledB();
        caller.getSizes(address(calledA), address(calledB));
        vm.stopPrank();
    }

    /*Checks the behaviour when two delegatecalls are chained together*/
    function test_doubleDelegate() public {
        vm.startPrank(alice);
        CalledFirst calledA = new CalledFirst();
        CalledLast calledB = new CalledLast();
        caller.delegateCallToFirst(address(calledA), address(calledB), true, true);
        vm.stopPrank();
    }

    /*Checks the behaviour when call and delegatecall are chained together*/
    function test_callAndDelegate() public {
        vm.startPrank(alice);
        CalledFirst calledA = new CalledFirst();
        CalledLast calledB = new CalledLast();
        caller.delegateCallToFirst(address(calledA), address(calledB), false, true);
        vm.stopPrank();
    }

    /*Checks the behaviour when delegatecall and call are chained together*/
    function test_delegateAndCall() public {
        vm.startPrank(alice);
        CalledFirst calledA = new CalledFirst();
        CalledLast calledB = new CalledLast();
        caller.delegateCallToFirst(address(calledA), address(calledB), true, false);
        vm.stopPrank();
    }
}

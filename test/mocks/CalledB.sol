pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract CalledB {
    function getCodeSize() public view returns (uint256 size) {
        console.log("contract sizeB:", address(this));
        console.log("Just to increase size");

        uint256 unused = 100;
        assembly {
            size := codesize()
        }
    }
}

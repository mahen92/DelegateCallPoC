pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract CalledA {
    function getCodeSize() public view returns (uint256 size) {
        console.log("contract sizeA:", address(this));

        assembly {
            size := codesize()
        }
    }
}

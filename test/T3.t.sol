// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/T3Init.sol";
import "../src/T3.sol";

contract CounterTest is Test {
    T3 public t3;

    T3Init public init = new T3Init(address(this));

    function setUp() external {
        t3 = new T3();
    }

    function testAddress() external {
        bytes memory deploymentCode = abi.encodePacked(
            type(T3Init).creationCode,
            address(this)
        );
        address deploymentAddress = t3.getAddress(deploymentCode, 269);
        assert(deploymentAddress != address(0));
    }
}

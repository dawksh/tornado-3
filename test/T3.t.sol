// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/T3Init.sol";
import "../src/T3.sol";

contract CounterTest is Test {
    T3 public t3;

    bytes deploymentCode = abi.encodePacked(type(T3Init).creationCode, abi.encode(address(this)));

    function setUp() external {
        t3 = new T3();
    }

    function testAddressComputation() external view {
        address deploymentAddress = t3.getAddress(deploymentCode, 269);
        assert(deploymentAddress != address(0));
    }

    function testAddressDeployment() external {
        address deploymentAddress = t3.getAddress(deploymentCode, 269);
        assertEq(deploymentAddress, t3.deploy(269));
    }

    function testSendingFunds() external {
        address preCompute = t3.getAddress(deploymentCode, 269);
        (bool s,) = address(preCompute).call{value: 1 ether}("");
        require(s);
        uint256 bal = address(this).balance;
        t3.deploy(269);
        assertEq(bal + 1 ether, address(this).balance);
    }

    function testInvalidAddress() external {
        address preCompute = t3.getAddress(deploymentCode, 269);
        address deployed = t3.deploy(270);
        assert(preCompute != deployed);
    }
}

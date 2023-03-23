// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./T3Init.sol";

contract T3 {
    event Deployed(address indexed caller, uint256 salt, address precompute);

    function getAddress(bytes memory bytecode, uint256 _salt) public view returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode)));

        return address(uint160(uint256(hash)));
    }

    function deploy(uint256 salt) public payable returns (address) {
        address addr = address(new T3Init{salt: bytes32(salt)}(msg.sender));
        emit Deployed(msg.sender, salt, addr);
        return addr;
    }
}

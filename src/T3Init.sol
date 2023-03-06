// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract T3Init {
    constructor(address sender) {
        selfdestruct(payable(sender));
    }
}

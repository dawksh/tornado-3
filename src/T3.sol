// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract T3 {
    event Deployed(address indexed caller, uint256 salt, address precompute);

    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(bytecode)
            )
        );

        return address(uint160(uint256(hash)));
    }

    function deploy(bytes memory bytecode, uint256 _salt) public payable {
        address addr;

        assembly {
            addr := create2(
                callvalue(),
                add(bytecode, 0x20),
                mload(bytecode),
                _salt
            )

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        emit Deployed(msg.sender, _salt, addr);
    }
}

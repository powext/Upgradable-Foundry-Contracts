// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Contract for Proxy based on ERC1967Proxy
contract Proxy {
    // Address of the current implementation
    address private _implementation;

    // Data structure to hold the slots
    mapping(bytes32 => bytes32) private _slots;

    constructor(address _initialImplementation) {
        _implementation = _initialImplementation;
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    function _fallback() private {
        bytes32 slot = keccak256(abi.encodePacked("implementation"));
        assembly {
            let _target := sload(slot)
            calldatacopy(0x0, 0x0, calldatasize())
            let result := delegatecall(gas(), _target, 0x0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    function upgradeTo(address newImplementation) external {
        _implementation = newImplementation;
    }

    function implementation() external view returns (address) {
        return _implementation;
    }
}


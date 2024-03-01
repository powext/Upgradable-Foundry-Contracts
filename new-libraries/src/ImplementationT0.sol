// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Contract for ImplementationT0
contract ImplementationT0 {
    uint public value;

    function initialize(uint _value) external {
        value = _value;
    }
    
    function updateValue(uint _newValue) external {
        value = _newValue;
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Contract for ImplementationT1 (updated version)
contract ImplementationT1 {
    string public message;

    function initialize(string memory _message) external {
        message = _message;
    }
    
    function updateMessage(string memory _newMessage) external {
        message = _newMessage;
    }
}


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Import of the Parent contract
import "./Parent.sol";

// Definition of the Son contract inheriting from Parent
contract Son is Parent {
    
    constructor(string memory _name) Parent(_name) {}

    // Override of the view function for Son
    function viewDescription() public view virtual override returns (string memory) {
        return "I'm a Son";
    }
}


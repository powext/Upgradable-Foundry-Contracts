// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Import of the Parent contract
import "./Parent.sol";

// Definition of the Daughter contract inheriting from Parent
contract Daughter is Parent {

    constructor(string memory _name) Parent(_name) {}
    
    // Override of the view function for Daughter
    function viewDescription() public view virtual override returns (string memory) {
        return "I'm a Daughter";
    }
}


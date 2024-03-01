// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Import of the Human contract
import "./BasicDefinition.sol";

// Definition of the Parent contract inheriting from Human
contract ImplementationWithBug is BasicDefinition {

    // Override of the view function for Parent
    function sum(uint a, uint b) public view virtual override returns (uint) {
        console.log("sum would be increased by 1 in this version instead of: ", a + b);
        return 1 + a + b;
    }
}

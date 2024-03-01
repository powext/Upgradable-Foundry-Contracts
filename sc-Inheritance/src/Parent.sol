// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Import of the Human contract
import "./Human.sol";

// Definition of the Parent contract inheriting from Human
contract Parent is Human {

    // Costruttore - inizializza il numero dei figli
    constructor(string memory _name) Human(_name) {}
    
    // Override of the view function for Parent
    function viewDescription() public view virtual override returns (string memory) {
        return "I'm a Parent";
    }
}

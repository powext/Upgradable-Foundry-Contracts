// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@oz-upgradeable/security/PausableUpgradeable.sol";
import "@oz-upgradeable/access/OwnableUpgradeable.sol";
import "@oz-upgradeable/proxy/utils/Initializable.sol";

// MyContract contract that inherits from Initializable, PausableUpgradeable, and OwnableUpgradeable.
contract MyContract is Initializable, PausableUpgradeable, OwnableUpgradeable {
    uint256 public x;  // Public state variable 'x'.

    // Constructor function that disables the initializer.
    constructor() {
        _disableInitializers();
    }

    // Initialize function that sets the initial state of the contract.
    function initialize(uint _x) public initializer {
        __Pausable_init();  // Initialize the Pausable contract.
        __Ownable_init();  // Initialize the Ownable contract.
        x = _x;  // Set the value of 'x'.
    }

    // Function to pause the contract. Only the owner can call this function.
    function pause() public onlyOwner {
        _pause();
    }

    // Function to unpause the contract. Only the owner can call this function.
    function unpause() public onlyOwner {
        _unpause();
    }
}

// MyContractV2 contract that inherits from Initializable, PausableUpgradeable, and OwnableUpgradeable.
contract MyContractV2 is Initializable, PausableUpgradeable, OwnableUpgradeable {
    uint256 public x;  // Public state variable 'x'.
    uint256 public y;  // Public state variable 'y'.

    // Function to set the value of 'y'.
    function setY(uint _y) external {
        y = _y;
    }

    // Constructor function that disables the initializer.
    constructor() {
        _disableInitializers();
    }

    // Initialize function that sets the initial state of the contract.
    function initialize() public initializer {
        __Pausable_init();  // Initialize the Pausable contract.
        __Ownable_init();  // Initialize the Ownable contract.
    }

    // Function to pause the contract. Only the owner can call this function.
    function pause() public onlyOwner {
        _pause();
    }

    // Function to unpause the contract. Only the owner can call this function.
    function unpause() public onlyOwner {
        _unpause();
    }
}



/* ------------------------------------------------------------------------------------------------ */
/* ------------------------------------------------------------------------------------------------ */
/* ---------------------------------------  EXPLANATION ------------------------------------------- */
/* ------------------------------------------------------------------------------------------------ */
/* ------------------------------------------------------------------------------------------------ */

/*

    This contract uses the OpenZeppelin Contracts library to create an upgradeable, ownable, and pausable contract.
    The MyContract contract is the initial version of the contract, and the MyContractV2 contract is a new version
    that adds a new state variable y and a function to set its value. The initialize function is used to set the
    initial state of the contract, and the initializer modifier is used to ensure that the initialize function can
    only be called once. The pause and unpause functions are used to pause and unpause the contract. The setY function
    is used to set the value of the y state variable. The constructor function in both contracts is used to disable the
    initializers to prevent them from being called more than once. The PausableUpgradeable, OwnableUpgradeable, and
    Initializable contracts are imported from the OpenZeppelin Contracts library, and they provide the functionality for
    pausable, ownable, and initializable contracts.
    
    The SPDX License Identifier: MIT comment at the top of the file specifies the license of the contract. The pragma
    solidity ^0.8.12; line specifies the version of Solidity that the contract is written in. The onlyOwner modifier
    is used to restrict a function to be callable only by the owner of the contract. The _x and _y variables are used to
    store the initial value of x and the value of y, respectively. The x and y state variables are used to store the
    state of the contract. The __Pausable_init(), __Ownable_init(), and _disableInitializers() functions are used to
    initialize the PausableUpgradeable, OwnableUpgradeable, and disable the initializers of the contract.
    
    The @custom:oz-upgrades-unsafe-allow constructor comment is used to allow the use of a constructor in an upgradeable
    contract, which is generally unsafe and not recommended.
    
    The initializer modifier is used to ensure that a function can only be called once during the initialization of the contract.
    The onlyOwner modifier is used to restrict a function to be callable only by the owner of the contract. The external keyword
    is used to specify that a function can only be called from outside the current contract. The public keyword is used to specify
    that a function can be called by any account. The view keyword is used to specify that a function does not modify the state
    of the contract. The returns (uint256) part of a function declaration specifies the return type of the function.
    
*/
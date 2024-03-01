// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8;


import "@oz-upgradeable/security/PausableUpgradeable.sol";
import "@oz-upgradeable/access/OwnableUpgradeable.sol";
import "@oz-upgradeable/proxy/utils/Initializable.sol";
import "@oz-upgradeable/proxy/utils/UUPSUpgradeable.sol";

import "@oz/proxy/ERC1967/ERC1967Proxy.sol";

// MyContractV2 contract that inherits from Initializable, PausableUpgradeable, OwnableUpgradeable, and UUPSUpgradeable.
contract ImplementationV2 is Initializable, PausableUpgradeable, OwnableUpgradeable, UUPSUpgradeable{
    string public version;  // Public state variable 'version'.
    string public age;  // Public state variable 'age'.

    // Constructor function that disables the initializer.
    constructor() {
        _disableInitializers();
    }

    // Initialize function that sets the initial state of the contract.
    function initialize() public initializer {
        __Pausable_init();  // Initialize the Pausable contract.
        __Ownable_init();  // Initialize the Ownable contract.
        __UUPSUpgradeable_init();  // Initialize the UUPSUpgradeable contract.
    }

    // Function to set the value of 'age'.
    function setAge(string memory _age) public {
        age = _age;
    }

    // Function to get the value of 'age'.
    function getAge() public view returns (string memory) {
        return age;
    }

    // Function to pause the contract. Only the owner can call this function.
    function pause() public onlyOwner {
        _pause();
    }

    // Function to unpause the contract. Only the owner can call this function.
    function unpause() public onlyOwner {
        _unpause();
    }

    // Function to authorize an upgrade. Only the owner can call this function.
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    // Function to get the implementation address.
    function getImplementation() external view returns (address) {
        return _getImplementation();
    }
}
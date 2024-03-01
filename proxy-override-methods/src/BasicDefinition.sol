// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Import of the OpenZeppelin contracts
import "@oz-upgradeable/security/PausableUpgradeable.sol";
import "@oz-upgradeable/access/OwnableUpgradeable.sol";
import "@oz-upgradeable/proxy/utils/Initializable.sol";
import "@oz-upgradeable/proxy/utils/UUPSUpgradeable.sol";

import "@std/console.sol";
import "@oz/utils/Strings.sol";


// Definition of the Human contract
contract BasicDefinition is OwnableUpgradeable, UUPSUpgradeable{
    using Strings for uint256;

    string private _version;

    // Constructor function that disables the initializer.
    function initialize(string memory version) public initializer {
        OwnableUpgradeable.__Ownable_init();
        _version = version;
    }

    function updateVersion(string memory newVersion) public onlyOwner {
        _version = newVersion;
    }

    function getVersion() public view returns (string memory) {
        // DEBUG
        console.log(_version);
        return _version;
    }

    function _authorizeUpgrade(address newImplementation) internal virtual override onlyOwner {}

    // View function returning the entity type
    function sum(uint a, uint b) public view virtual returns (uint) {
        console.log(_version);
        console.log("sum would be 0 in this version instead of: ", a + b);
        return 0;
    }
}



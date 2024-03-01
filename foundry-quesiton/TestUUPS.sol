// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;

import "@oz-upgradeable/security/PausableUpgradeable.sol";
import "@oz-upgradeable/access/OwnableUpgradeable.sol";
import "@oz-upgradeable/proxy/utils/Initializable.sol";
import "@oz-upgradeable/proxy/utils/UUPSUpgradeable.sol";

import "@oz/proxy/ERC1967/ERC1967Proxy.sol";

// UUPSProxy contract that inherits from ERC1967Proxy.
contract UUPSProxy is ERC1967Proxy {
    // Constructor function that initializes the proxy with the implementation address and data.
    constructor(address _implementation, bytes memory _data) ERC1967Proxy(_implementation, _data) {}
}

// MyContract contract that inherits from Initializable, PausableUpgradeable, OwnableUpgradeable, and UUPSUpgradeable.
contract MyContract is Initializable, PausableUpgradeable, OwnableUpgradeable, UUPSUpgradeable{
    string public version;  // Public state variable 'version'.

    // Constructor function that disables the initializer.
    constructor() {
        _disableInitializers();
    }

    // Initialize function that sets the initial state of the contract.
    function initialize(string memory _version) public initializer {
        __Pausable_init();  // Initialize the Pausable contract.
        __Ownable_init();  // Initialize the Ownable contract.
        __UUPSUpgradeable_init();  // Initialize the UUPSUpgradeable contract.
        version = _version;  // Set the value of 'x'.
    }

    // Function to set the value of 'version'.
    function setVersion(string memory _version) public {
        version = _version;
    }

    // Function to get the value of 'version'.
    function getVersion() public view returns (string memory) {
        return version;
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

// MyContractV2 contract that inherits from Initializable, PausableUpgradeable, OwnableUpgradeable, and UUPSUpgradeable.
contract MyContractV2 is Initializable, PausableUpgradeable, OwnableUpgradeable, UUPSUpgradeable{
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


/* ------------------------------------------------------------------------------------------------ */
/* ------------------------------------------------------------------------------------------------ */
/* ---------------------------------------  EXPLANATION ------------------------------------------- */
/* ------------------------------------------------------------------------------------------------ */
/* ------------------------------------------------------------------------------------------------ */

/*

    This contract uses the UUPS (Universal Upgradeable Proxy Standard) pattern for upgradeable contracts.
    It includes two versions of a contract (MyContract and MyContractV2) and a proxy contract (UUPSProxy).

    The MyContract and MyContractV2 contracts are upgradeable, ownable, and pausable.
    The state of these contracts can be upgraded by deploying a new version of the contract and updating
    the implementation address in the proxy. The contracts can also be paused and unpaused by the owner.

    The UUPSProxy contract is used to delegate calls to the implementation contract and to upgrade the
    implementation address. The proxy contract uses the ERC1967 standard for upgradeable contracts.

    The initialize function is used to set the initial state of the contract, and the initializer modifier
    is used to ensure that the initialize function can only be called once. The _authorizeUpgrade function
    is used to authorize an upgrade to a new implementation. The getImplementation function is used to get
    the address of the current implementation contract. The pause and unpause functions are used to pause
    and unpause the contract.

    The setY function in MyContractV2 is used to set the value of the y state variable. The constructor
    function in both contracts is used to disable the initializers to prevent them from being called more
    than once. The PausableUpgradeable, OwnableUpgradeable, and UUPSUpgradeable contracts are imported from
    the OpenZeppelin Contracts library, and they provide the functionality for pausable, ownable, and
    upgradeable contracts.

    The ERC1967Proxy contract is imported from the OpenZeppelin Contracts library, and it provides the
    functionality for an upgradeable proxy contract that uses the ERC1967 standard. The Initializable contract
    is imported from the OpenZeppelin Contracts library, and it provides the functionality for initializing
    contracts in an upgradeable context.

    The ERC1967Proxy(_implementation, _data) part of the constructor declaration is used to call the constructor of the
    ERC1967Proxy contract with the implementation address and data as arguments. The __Pausable_init(), __Ownable_init(),
    and __UUPSUpgradeable_init() functions are used to initialize the PausableUpgradeable, OwnableUpgradeable, and
    UUPSUpgradeable contracts, respectively. The _upgradeTo(address(newDad)) function is used to upgrade the implementation
    address of the proxy contract. The require(implementation != address(0)) statement is used to ensure that the implementation
    address is not the zero address. The assembly block is used to write inline assembly code, which allows for low-level
    operations on the Ethereum Virtual Machine (EVM). The:
    let ptr := mload(0x40), calldatacopy(ptr, 0, calldatasize()),
    let result := delegatecall(gas(), implementation, ptr, calldatasize(), 0, 0),
    let size := returndatasize(), returndatacopy(ptr, 0, size), switch result,
    case 0 { revert(ptr, size) },
    and default { return(ptr, size) }
    lines of code inside the assembly block are used to delegate all calls to the implementation contract.The fallback() external
    payable function is used to enable the contract to receive ether and to delegate all calls to the implementation contract.
    The external keyword is used to specify that a function can only be called from outside the current contract. The payable
    keyword is used to specify that a function can receive ether.

    The SPDX License Identifier: AGPL-3.0-only comment at the top of the file specifies the license of the contract.
    The pragma solidity ^0.8.12; line specifies the version of Solidity that the contract is written in.
    The @custom:oz-upgrades-unsafe-allow constructor comment is used to allow the use of a constructor in an
    upgradeable contract, which is generally unsafe and not recommended.

    The public keyword is used to specify that a function can be called by any account. The internal keyword is used
    to specify that a function can only be called from within the current contract or contracts deriving from it.
    The override keyword is used to specify that a function overrides a function in a base contract. The onlyOwner
    modifier is used to restrict a function to be callable only by the owner of the contract. The view keyword is used
    to specify that a function does not modify the state of the contract. The returns (address) part of a function
    declaration specifies the return type of the function. The address keyword is used to specify an Ethereum address.
    The uint256 keyword is used to specify an unsigned integer of 256 bits. The string keyword is used to specify a string.
    The memory keyword is used to specify that a variable is a memory variable. The bytes keyword is used to specify a
    dynamically-sized byte array. The _implementation, _data, _x, _y, newImplementation, and newName variables are used
    to store the implementation address, data for the constructor, initial value of x, value of y, new implementation
    address, and new name, respectively. The x and y state variables are used to store the state of the contract.
    The name state variable is used to store the name of the contract.

*/
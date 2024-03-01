// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Definition of the Human contract
contract Human {
    // State variable to store the name of the person
    string public name;

    // Event emitted when the name is changed
    event NameChanged(string newName);

    // Modifier to allow only the owner to call a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Owner of the contract
    address public owner;

    // Constructor - sets the initial name and the owner's address
    constructor(string memory _name) {
        name = _name;
        owner = msg.sender;
    }

    // Function to change the name (can only be called by the owner)
    function changeName(string memory _newName) public onlyOwner {
        name = _newName;
        emit NameChanged(_newName);
    }

    // View function returning the entity type
    function viewDescription() public view virtual returns (string memory) {
        return "I'm an Human";
    }
}



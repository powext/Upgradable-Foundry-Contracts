// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";
import {Script, console2} from "@std/Script.sol";

import "../src/ImplementationV1.sol";

// DeployUUPS contract that inherits from Script.
contract ImplementationV1Script is Script {

    function setUp() public {}

    function run() public {
        // Start the VM broadcast.
        // vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vm.broadcast();

        // Wrap the proxy contract in the implementation_1 to support easier calls.
        ImplementationV1 implementationV1 = new ImplementationV1();
        console.log("implementationV1: ", address(implementationV1));

        // Write the address of the implementation already deployed.
        _writeImplementationV1(addressToString(address(implementationV1)));

        //vm.stopBroadcast();
    }
    
    function _writeImplementationV1(string memory data) internal {
        // Getting the implementation address from the VM storage.
        string memory path = "./contracts/broadcast/implementationV1.txt";
        vm.writeFile(path, data);
    }

    // Function to convert an address to a string
    function addressToString(address _address) public pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(_address)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(42);
        str[0] = '0';
        str[1] = 'x';
        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint(uint8(value[i + 12] >> 4))];
            str[3+i*2] = alphabet[uint(uint8(value[i + 12] & 0x0f))];
        }
        return string(str);
    }
}

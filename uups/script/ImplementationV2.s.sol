// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";

import "../src/ImplementationV1.sol";
import "../src/ImplementationV2.sol";
import "../src/UUPSProxy.sol";
import {Script, console2} from "@std/Script.sol";

// DeployUUPS contract that inherits from Script.
contract ImplementationV2Script is Script {

    function setUp() public {}

    function run() public {
        // Start the VM broadcast.
        // vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vm.broadcast();
        // Create te contract implementation_2.
        ImplementationV2 implementationV2 = new ImplementationV2();
        console.log("implementationV2: ", address(implementationV2));

        // Get the address of the first implementation already deployed.
        address implementationV1 = getImplementationV1();
        console.log("implementationV1: ", implementationV1);

        // Get the address of the proxy already deployed.
        address proxyAddress = getProxyAddress();
        console.log("proxyAddress: ", proxyAddress);

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        ImplementationV1 impWrapped1 = ImplementationV1(proxyAddress);

        // Upgrade the wrapped proxy contract to the new implementation.
        impWrapped1.upgradeTo(address(implementationV2));
        
        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        ImplementationV2 impWrapped2 = ImplementationV2(proxyAddress);

        // Set the value of 'age' in the re-wrapped proxy contract to a1.
        impWrapped2.setAge("a1");

        // Write the address of the implementation already deployed.
        _writeImplementationV2(addressToString(address(implementationV2)));

        //vm.stopBroadcast();
    }
    

    function getImplementationV1() public payable returns (address) {
        // Getting the implementation address from the VM storage.
        string memory addressV1 = vm.readFile("./contracts/broadcast/implementationV1.txt");

        // Return
        return stringToAddress(addressV1);
    }
    

    function getProxyAddress() public payable returns (address) {
        // Getting the implementation address from the VM storage.
        string memory addressV1 = vm.readFile("./contracts/broadcast/UUPSProxy.txt");

        // Return
        return stringToAddress(addressV1);
    }
    
    function stringToAddress(string memory _address) public pure returns (address) {
        bytes memory addr = bytes(_address);
        uint160 result = 0;
        for (uint i = 2; i < addr.length; i++) {
            uint160 value = uint160(uint8(addr[i]));
            if (value >= 48 && value <= 57) {
                result *= 16;
                result += (value - 48);
            } else if (value >= 65 && value <= 70) {
                result *= 16;
                result += (value - 55);
            } else if (value >= 97 && value <= 102) {
                result *= 16;
                result += (value - 87);
            } else {
                revert("Invalid character encountered");
            }
        }
        return address(result);
    }
    
    function _writeImplementationV2(string memory data) internal {
        // Getting the implementation address from the VM storage.
        string memory path = "./contracts/broadcast/implementationV2.txt";
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

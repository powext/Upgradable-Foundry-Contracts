// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";

import "../src/TestUUPS.sol";
import "../script/TestSetUp.s.sol";

// DeployUUPS contract that inherits from Script.
contract TestUpgrade is Script {
    // State variables for the contract.
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;

    // run function to deploy and upgrade the contract.
    function run() public {
        vm.broadcast();

        // Create a new MyContractV2 contract.
        MyContractV2 implementationV2 = new MyContractV2();
        
        // Using the address of the deployed contract to upgrade the contract.
        address proxyAddress = 0xC7f2Cf4845C6db0e1a1e91ED41Bcd0FcC1b0E141;

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        wrappedProxyV1 = MyContract(proxyAddress);

        // Upgrade the wrapped proxy contract to the new implementation.
        wrappedProxyV1.upgradeTo(address(implementationV2));
        
        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        wrappedProxyV2 = MyContractV2(proxyAddress);

        // Set the value of 'age' in the re-wrapped proxy contract to a1.
        wrappedProxyV2.setAge("a1");

        // Log the values of 'version' and 'age' in the re-wrapped proxy contract, which should be v1 and a1 respectively.
        console.log(wrappedProxyV2.version(), wrappedProxyV2.age());
    }
}

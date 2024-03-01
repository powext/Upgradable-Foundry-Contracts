// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";

import "../src/TestUUPS.sol";

// DeployUUPS contract that inherits from Script.
// Time 0 --> Create the proxy contract and the first implementation managed through the proxy.
contract TestSetUp is Script {    

    UUPSProxy public myProxy;

    // run function to deploy and upgrade the contract.
    function run() public {
        vm.broadcast();

        // Create a new MyContract contract. 
        // It is the first implementation of the contract.
        MyContract implementationV1 = new MyContract();
        
        // Deploy a new UUPSProxy contract and point it to the MyContract implementation.
        myProxy = new UUPSProxy(address(implementationV1), "");

        // Logs the address of the implementation and the proxy.
        console.log("implementationV1 address: ", address(implementationV1));
        console.log("proxy address: ", address(myProxy));
        
        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        MyContract wrappedProxyV1 = MyContract(address(myProxy));

        // Initialize the wrapped proxy contract with a value of 'imp1'.
        wrappedProxyV1.initialize("imp1");

        // Log the value of 'version' in the wrapped proxy contract, which should be 'imp1'.
        console.log(wrappedProxyV1.getVersion());
    }
}

// DeployUUPS contract that inherits from Script.
contract TestUpgrade is Script {

    // run function to deploy and upgrade the contract.
    function run() public {
        vm.broadcast();

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        //MyContract wrappedProxyV1 = MyContract(address(myProxy));

        // Create a new MyContractV2 contract.
        // It is the second implementation of the contract.
        //MyContractV2 implementationV2 = new MyContractV2();

        // Upgrade the wrapped proxy contract to the new implementation.
        //wrappedProxyV1.upgradeTo(address(implementationV2));
        
        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        // MyContractV2 wrappedProxyV2 = MyContractV2(address(myProxy));

        // Set the value of 'age' in the re-wrapped proxy contract to 'age1'.
        //wrappedProxyV2.setAge("age1");

        // Log the values of 'version' and 'age' in the re-wrapped proxy contract, which should be 'imp1' and 'age1' respectively.
        //console.log(wrappedProxyV2.version(), wrappedProxyV2.age());
    }
}

// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";

import "../src/TestUUPS.sol";

// DeployUUPS contract that inherits from Script.
contract TestUUPS is Script {
    // State variables for the contract.
    UUPSProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;

    // run function to deploy and upgrade the contract.
    function run() public {
        vm.broadcast();

        // Create a new MyContract contract.
        MyContract implementationV1 = new MyContract();
        
        //bytes memory my_data = abi.encodeWithSignature("initialize(uint256)", 50);

        // Deploy a new UUPSProxy contract and point it to the MyContract implementation.
        //proxy = new UUPSProxy(address(implementationV1), my_data);
        proxy = new UUPSProxy(address(implementationV1), "");
        console.log("implementationV1 address: ", address(implementationV1));
        console.log("proxy address: ", address(proxy));
        
        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        wrappedProxyV1 = MyContract(address(proxy));

        // Initialize the wrapped proxy contract with a value of v1.
        wrappedProxyV1.initialize("v1");

        // Log the value of 'version' in the wrapped proxy contract, which should be 100.
        console.log(wrappedProxyV1.getVersion());
        console.log(wrappedProxyV1.version());

        // Create a new MyContractV2 contract.
        MyContractV2 implementationV2 = new MyContractV2();

        // Upgrade the wrapped proxy contract to the new implementation.
        wrappedProxyV1.upgradeTo(address(implementationV2));
        
        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        wrappedProxyV2 = MyContractV2(address(proxy));

        // Set the value of 'age' in the re-wrapped proxy contract to a1.
        wrappedProxyV2.setAge("a1");

        // Log the values of 'version' and 'age' in the re-wrapped proxy contract, which should be v1 and a1 respectively.
        console.log(wrappedProxyV2.version(), wrappedProxyV2.age());
        console.log(wrappedProxyV2.version(), wrappedProxyV2.getAge());
    }
}

// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";
import "@oz/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@oz/proxy/transparent/ProxyAdmin.sol";

import "../src/UpgradeTransparent.sol";

// DeployTransparent contract that inherits from Script.
contract DeployTransparent is Script {
    // State variables for the contract.
    MyContract implementationV1;
    TransparentUpgradeableProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;
    ProxyAdmin admin;

    // run function to deploy and upgrade the contract.
    function run() public {
        // Create a new ProxyAdmin contract.
        admin = new ProxyAdmin();

        // Create a new MyContract contract.
        implementationV1 = new MyContract();
        
        // Deploy a new TransparentUpgradeableProxy contract and point it to the MyContract implementation.
        proxy = new TransparentUpgradeableProxy(address(implementationV1), address(admin), "");
        
        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        wrappedProxyV1 = MyContract(address(proxy));

        // Initialize the wrapped proxy contract with a value of 100.
        wrappedProxyV1.initialize(100);

        // Log the value of 'x' in the wrapped proxy contract, which should be 100.
        console.log(wrappedProxyV1.x());

        // Create a new MyContractV2 contract.
        MyContractV2 implementationV2 = new MyContractV2();

        // Upgrade the proxy contract to the new implementation using the admin contract.
        admin.upgrade(proxy, address(implementationV2));
        
        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        wrappedProxyV2 = MyContractV2(address(proxy));

        // Set the value of 'y' in the re-wrapped proxy contract to 200.
        wrappedProxyV2.setY(200);

        // Log the values of 'x' and 'y' in the re-wrapped proxy contract, which should be 100 and 200 respectively.
        console.log(wrappedProxyV2.x(), wrappedProxyV2.y());
    }
    
}

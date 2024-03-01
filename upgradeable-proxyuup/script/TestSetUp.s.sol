// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";

import "../src/TestUUPS.sol";

// DeployUUPS contract that inherits from Script.
contract TestSetUp is Script {

    UUPSProxy public proxy;

    // run function to deploy and upgrade the contract.
    function run() public {
        vm.broadcast();

        // Getting the owner of the contract to the address that deployed it.
        address owner = msg.sender;

        // printing the ownnwer address
        console.log("owner address: ", owner);

        // Create a new MyContract contract.
        MyContract implementationV1 = new MyContract();
        
        // Deploy a new UUPSProxy contract and point it to the MyContract implementation.
        proxy = new UUPSProxy(address(implementationV1), "");
        console.log("implementationV1 address: ", address(implementationV1));
        console.log("proxy address: ", address(proxy));
        
        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        MyContract wrappedProxyV1 = MyContract(address(proxy));

        // Initialize the wrapped proxy contract with a value of v1.
        wrappedProxyV1.initialize("v1");

        // Log the value of 'version' in the wrapped proxy contract, which should be 100.
        console.log(wrappedProxyV1.getVersion());

        console.log(address(proxy));
    }

    function getProxy() public view returns (UUPSProxy) {
        return proxy;
    }
}

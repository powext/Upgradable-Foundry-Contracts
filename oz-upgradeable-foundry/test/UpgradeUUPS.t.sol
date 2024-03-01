// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import {PRBTest} from "@prb/test/PRBTest.sol";
import "@std/console.sol";

import "../src/UpgradeUUPS.sol";

// _Test contract that inherits from PRBTest.
contract _Test is PRBTest {
    // State variables for the contract.
    MyContract implementationV1;
    UUPSProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;

    // setUp function to initialize the state of the contract.
    function setUp() public {
        // Create a new MyContract contract.
        implementationV1 = new MyContract();

        // Deploy a new UUPSProxy contract and point it to the MyContract implementation.
        proxy = new UUPSProxy(address(implementationV1), "");

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        wrappedProxyV1 = MyContract(address(proxy));

        // Initialize the wrapped proxy contract with a value of 100.
        wrappedProxyV1.initialize(100);
    }

    // Test function to check if the contract can be initialized.
    function testCanInitialize() public {
        // Assert that the value of 'x' in the wrapped proxy contract is 100.
        assertEq(wrappedProxyV1.x(), 100);
    }

    // Test function to check if the contract can be upgraded.
    function testCanUpgrade() public {
        // Create a new MyContractV2 contract.
        MyContractV2 implementationV2 = new MyContractV2();

        // Upgrade the wrapped proxy contract to the new implementation.
        wrappedProxyV1.upgradeTo(address(implementationV2));

        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        wrappedProxyV2 = MyContractV2(address(proxy));

        // Assert that the value of 'x' in the re-wrapped proxy contract is still 100.
        assertEq(wrappedProxyV2.x(), 100);

        // Set the value of 'y' in the re-wrapped proxy contract to 200.
        wrappedProxyV2.setY(200);

        // Assert that the value of 'y' in the re-wrapped proxy contract is now 200.
        assertEq(wrappedProxyV2.y(), 200);
    }
}

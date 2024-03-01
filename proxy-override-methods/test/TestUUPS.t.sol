// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import {PRBTest} from "@prb/test/PRBTest.sol";
import "@std/console.sol";

import "../src/UUPSProxy.sol";
import "../src/ImplementationWithBug.sol";
import "../src/ImplementationFixed.sol";

// _Test contract that inherits from PRBTest.
contract _Test is PRBTest {
    // State variables for the contract.
    UUPSProxy proxy;
    ImplementationWithBug wrappedProxyWithBug;
    ImplementationFixed wrappedProxyFixed;

    // Possible variables
    uint public x;
    uint public y;

    // setUp function to initialize the state of the contract.
    function setUp() public {
        // Initialize variables
        x = 10;
        y = 20;

        // Create a new implementationt with the wrong logic
        ImplementationWithBug implementationWithBug = new ImplementationWithBug();

        // Deploy a new UUPSProxy contract and point it to the MyContract implementation.
        proxy = new UUPSProxy(address(implementationWithBug), "");

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        wrappedProxyWithBug = ImplementationWithBug(address(proxy));

        // Initialize the wrapped proxy contract with the related version.
        wrappedProxyWithBug.initialize("WithBug_VERSION");
    }

    // Test function to check if the contract works as expected.
    function testImplemetationWithBug() public {
        assertEq(wrappedProxyWithBug.sum(x, y), 31); //IT SHOULD BE 30 --> NOT 31
        console.log("SUM RETURN 31 INSTEAD OF 30 --> BUGGED");
    }

    // Test function to check if the contract can be upgraded.
    function testCanUpgrade() public {
        // Create a new MyContractV2 contract.
        ImplementationFixed implementationFixed = new ImplementationFixed();

        // Upgrade the wrapped proxy contract to the new implementation.
        wrappedProxyWithBug.upgradeTo(address(implementationFixed));

        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        wrappedProxyFixed = ImplementationFixed(address(proxy));

        // Initialize the wrapped proxy contract with the related version.
        wrappedProxyFixed.updateVersion("Fixed_VERSION");

        // Assert that the value of 'x' in the re-wrapped proxy contract is still 100.
        assertEq(wrappedProxyFixed.sum(x, y), 30);

        console.log("SUM RETURN 30 AS EXPECTED --> FIXED");
    }
}

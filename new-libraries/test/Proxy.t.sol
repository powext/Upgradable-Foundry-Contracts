// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console}      from "forge-std/Test.sol";
import {Proxy}              from "../src/Proxy.sol";
import {ImplementationT0}   from "../src/ImplementationT0.sol";
import {ImplementationT1}   from "../src/ImplementationT1.sol";

contract ProxyTest is Test {
    Proxy public proxy;
    ImplementationT0 public implementationT0;
    ImplementationT1 public implementationT1;

    function setUp() public {
        // Create a new MyContract contract.
        implementationT0 = new ImplementationT0();
        implementationT0.initialize(0);

        // Deploy a new UUPSProxy contract and point it to the MyContract implementation.
        proxy = new Proxy(address(implementationT0));
    }

    function test_SetUp() public {
        // Utilizza il proxy per accedere alla funzione nell'implementazione T0
        uint valueFromProxyT0 = ImplementationT0(proxy.implementation()).value(); // Ottieni il valore (deve essere 0)
        assertEq(valueFromProxyT0, 0);
    }

    function test_UpgradeT0Value() public{
        // Aggiorna l'implementazione del proxy T0
        implementationT0.updateValue(10);

        // Utilizza il proxy per accedere alla funzione nell'implementazione T0
        uint valueFromProxyT0 = ImplementationT0(proxy.implementation()).value(); // Ottieni il valore (deve essere 10)
        assertEq(valueFromProxyT0, 10);
    }

    function test_UpgrateToT1() public {
        // Deploy a new implementation T1
        implementationT1 = new ImplementationT1();
        implementationT1.initialize("Hello, World!");

        // Aggiorna l'implementazione del proxy T1
        proxy.upgradeTo(address(implementationT1));

        // Utilizza il proxy per accedere alla funzione nell'implementazione T1
        string memory messageFromProxyT1 = ImplementationT1(proxy.implementation()).message(); // Ottieni il messaggio (deve essere "Hello, World!")
        assertEq(messageFromProxyT1, "Hello, World!");

        // Aggiorna l'implementazione del proxy T1
        implementationT1.updateMessage("Adios");        

        // Utilizza il proxy per accedere alla funzione nell'implementazione T1
        messageFromProxyT1 = ImplementationT1(proxy.implementation()).message(); // Ottieni il messaggio (deve essere "Adios")
        assertEq(messageFromProxyT1, "Adios");
    }
}

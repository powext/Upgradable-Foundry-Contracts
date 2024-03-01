// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Human}          from "../src/Human.sol";
import {Parent}         from "../src/Parent.sol";
import {Son}            from "../src/Son.sol";
import {Daughter}       from "../src/Daughter.sol";


contract InheritanceTest is Test {
    Human public human;
    Parent public parent;
    Son public son;
    Daughter public daughter;
    
    function setUp() public {
        human    = new Human("John Human");
        parent   = new Parent("John Parent");
        son      = new Son("John Son");
        daughter = new Daughter("John Daughter");
    }

    function test_Name() public {
        assertEq(human.name()   , "John Human");
        assertEq(parent.name()  , "John Parent");
        assertEq(son.name()     , "John Son");
        assertEq(daughter.name(), "John Daughter");
    }

    function test_Type() public {
        assertEq(human.viewDescription()   , "I'm an Human");
        assertEq(parent.viewDescription()  , "I'm a Parent");
        assertEq(son.viewDescription()     , "I'm a Son");
        assertEq(daughter.viewDescription(), "I'm a Daughter");
    }

    function test_Inheritance() public {
        Human h = new Human("H");
        Human p = new Parent("P");
        Human s = new Son("S");
        Human d = new Daughter("D");

        // The viewDescription function is called on the Human contract
        assertEq(h.viewDescription(), "I'm an Human");
        assertEq(p.viewDescription(), "I'm a Parent");
        assertEq(s.viewDescription(), "I'm a Son");
        assertEq(d.viewDescription(), "I'm a Daughter");
    }
}

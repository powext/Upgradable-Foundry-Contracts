// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HelloWorld} from 'src/HelloWorld.sol';

contract HelloWorldTest is Test {
    HelloWorld hello;
    
    function setUp() public {
      hello = new HelloWorld("Foundry is fast!");
    }

    function test1() public {
        assertEq(
            hello.greet(),
            "Foundry is fast!"
        );
    }

    function test2() public {
        assertEq(hello.version(), 0);
        hello.updateGreeting("Hello World");
        assertEq(hello.version(), 1);
        assertEq(
            hello.greet(),
            "Hello World"
        );
    }

    function test3(string memory _greeting) public {
        assertEq(hello.version(), 0);
        hello.updateGreeting(_greeting);
        assertEq(hello.version(), 1);
        assertEq(
            hello.greet(),
            _greeting
        );
    }

    function test4() public {
        assertEq(hello.version(), 0);
        hello.updateGreeting("Hello World");
        assertEq(hello.version(), 1);
        string memory value = hello.greet();
        emit log(value);
        assertEq(
            hello.greet(),
            "Hello World"
        );
    }
}
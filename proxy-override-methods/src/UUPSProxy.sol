// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import lobrary from OpenZeppelin
import "@oz/proxy/ERC1967/ERC1967Proxy.sol";

// UUPSProxy contract that inherits from ERC1967Proxy.
contract UUPSProxy is ERC1967Proxy {
    // Constructor function that initializes the proxy with the implementation address and data.
    constructor(address _implementation, bytes memory _data) ERC1967Proxy(_implementation, _data) {}
}
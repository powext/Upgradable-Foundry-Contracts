// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8;

import "@oz-upgradeable/security/PausableUpgradeable.sol";
import "@oz-upgradeable/access/OwnableUpgradeable.sol";
import "@oz-upgradeable/proxy/utils/Initializable.sol";
import "@oz-upgradeable/proxy/utils/UUPSUpgradeable.sol";

import "@oz/proxy/ERC1967/ERC1967Proxy.sol";

// UUPSProxy contract that inherits from ERC1967Proxy.
contract UUPSProxy is ERC1967Proxy {
    // Constructor function that initializes the proxy with the implementation address and data.
    constructor(address _implementation, bytes memory _data) ERC1967Proxy(_implementation, _data) {}
}

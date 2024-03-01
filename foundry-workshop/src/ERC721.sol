//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract DevconPanda is ERC721URIStorage {
    // using Counters for Counters.Counter;
    // Counters.Counter private _tokenIds;
    uint256 private _tokenIds = 0;

    constructor() ERC721("DevconPanda", "DCP") {}

    function mint(address user, string memory tokenURI) public returns (uint256) {
        uint256 newItemId = _tokenIds;  // Counter.current()
        _mint(user, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds = _tokenIds + 1; // Counter.increment()
        return newItemId;
    }
}
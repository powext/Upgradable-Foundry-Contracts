// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";
import "@std/StdCheats.sol";

import "../src/TestUUPS.sol";
import "../script/TestSetUp.s.sol";


contract TestUpgrade is Script {

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MyContractV2 implV2 = new MyContractV2();

        address proxyAddress = loadProxy();

        MyContract implV1 = MyContract(proxyAddress);
        console.log("owner: ", implV1.owner());
        console.log("msgSender: ", msg.sender);

        implV1.upgradeTo(address(implV2));
        implV2.upgradeVersion();
        console.log("version: ", implV2.getVersion());
        console.log("proxy address: ", proxyAddress);
        vm.stopBroadcast();
    }

    function loadProxy() private view returns (address) {
        string memory path = "proxy.txt";
        string memory fileContent = vm.readLine(path);
        address proxy = vm.parseAddress(fileContent);
        return proxy;
    }
}

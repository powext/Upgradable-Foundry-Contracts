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
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MyContract implV1 = new MyContract();
        proxy = new UUPSProxy(address(implV1), "");

        implV1 = MyContract(address(proxy));
        implV1.initialize();

        console.log("owner", implV1.owner());
        console.log("msgSender: ", msg.sender);
        console.log("version: ", implV1.getVersion());
        console.log("proxy address: ", address(proxy));

        vm.stopBroadcast();
        saveProxy(address(proxy));
    }

    function saveProxy(address _proxy) private {
        string memory path = "proxy.txt";
        vm.removeFile(path);
        vm.writeLine(path, vm.toString(_proxy));
    }

    function getProxy() public view returns (UUPSProxy) {
        return proxy;
    }
}

// SPDX-License-Identifier: AGPL-3.0-only
// This line specifies the license of the contract.

pragma solidity ^0.8.12;
// This line specifies the version of Solidity that the contract is written in.

// Importing necessary contracts from OpenZeppelin and other libraries.
import "@std/console.sol";
import "@std/Script.sol";

import "../src/TestUUPS.sol";
import "../script/TestSetUp.s.sol";

// DeployUUPS contract that inherits from Script.
contract TestUpgrade is Script {

    // run function to deploy and upgrade the contract.
    function run() public {
        vm.broadcast();

        // Address of the MyContractV1 implementation and the UUPSProxy contract. (These addresses are from the previous deployment.)
        address _implementationV1 = 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0;
        //address _proxy = 0xC7f2Cf4845C6db0e1a1e91ED41Bcd0FcC1b0E141;
        //address _owner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        
        // Get old owner address
        //console.log("old owner address: ", oldOwner);
        // update owner
        //msg.sender = _owner;

        //UUPSProxy proxy = TestSetUp().getProxy();        

        // Getting the owner of the contract to the address that deployed it.
        address owner = msg.sender;

        // printing the ownnwer address
        console.log("owner address: ", owner);

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        UUPSProxy proxy = new UUPSProxy(address(_implementationV1), "");
        //UUPSProxy proxy = new UUPSProxy(_proxy);

        // Wrap the proxy contract in the ABI of the MyContract contract to support easier calls.
        MyContract wrappedProxyV1 = MyContract(address(proxy));

        // Create a new MyContractV2 contract.
        MyContractV2 implementationV2 = new MyContractV2();

        // Upgrade the wrapped proxy contract to the new implementation.
        wrappedProxyV1.upgradeTo(address(implementationV2));
        
        // Re-wrap the proxy contract in the ABI of the MyContractV2 contract.
        MyContractV2 wrappedProxyV2 = MyContractV2(address(proxy));

        // Set the value of 'age' in the re-wrapped proxy contract to a1.
        wrappedProxyV2.setAge("a1");

        // Log the values of 'version' and 'age' in the re-wrapped proxy contract, which should be v1 and a1 respectively.
        console.log(wrappedProxyV2.version(), wrappedProxyV2.age());
    }
}

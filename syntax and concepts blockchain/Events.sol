//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Events {
    /**
     * What are events?
     * -> Events are 'logs' on the ethereum blockchain.
     *
     * You can use events to 'log' information on the blockchain, kind of for a proof of history that something happened at a certain block.
     *
     * Events have:
     *  1. name;
     *  2. arguments that you want to log;
     *
     * event TestFunctionCalled(address sender, string message);
     * 
     * function test() public {
        emit TestFunctionCalled(msg.sender, "Somebody Called Test()");
        }
     */

    event Transfer(address from, address to);

    address OwnerNFT;

    function transfer(address newOwner) public {
        require(msg.sender == OwnerNFT, "You cannot transfer");
        OwnerNFT = newOwner;

        emit Transfer(msg.sender, newOwner);
    }
}

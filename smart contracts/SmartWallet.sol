// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SmartWallet {
    //owner variable with address data type which can be viewed publicly
    address payable public owner;
    uint256 transactionCount;

    //once deployed the address that deployed the contract will become the owner that can receive funds
    constructor() {
        owner = payable(msg.sender);
    }

    event Transfer(
        address from,
        address to,
        uint256 amount,
        string message,
        uint256 timestamp
    );

    // default function that allows the smart contract to receive funds
    // smart contract can act a wallet and is able to receive and hold funds
    receive() external payable {}

    // function to withdraw eth from contract address
    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "Only the owner can call this method.");
        payable(msg.sender).transfer(_amount);
    }

    // function to send Eth from contract address to another wallet address
    function sendEth(
        address payable _to,
        uint256 _amount,
        string memory _message
    ) public {
        require(msg.sender == owner, "Only the owner can call this method");
        require(
            address(this).balance >= _amount,
            "The send amount is higher than the balance"
        );
        _to.transfer(_amount);

        emit Transfer(owner, _to, _amount, _message, block.timestamp);
    }

    // function to get balance of the contract address
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // function to get the address of the contract
    function getContractAddress() public view returns (address) {
        return address(this);
    }
}

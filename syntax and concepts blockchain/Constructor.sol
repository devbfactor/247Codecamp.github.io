//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// A constructor is an optional function that is executed when the contract is first deployed. You can also pass arguments to constructors.

// Constructor are function that only run once, that is when contract is deployed.
// You cannot call the constructor after the contract is deployed.
// Constructor is used to initialize state variables and pass arguments on it.

contract Constructor {
    // owner variable is a state variable
    address owner;

    // we use constructor function to initialize the variable owner
    // and set the address to someone who will deploy the contract.
    constructor() {
        owner = msg.sender;
    }
}

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Modifiers {
    /*
        Modifiers are pieces of code that can be run before
        or after function call.
    */

    //we delcare owner variable here.
    address owner;

    // using constructor functions, we initialize the owner variable and assign the
    // address who will call the function as the owner.
    constructor() {
        owner = msg.sender;
    }

    // Create a modifier that only allows a function to be called by the owner
    modifier onlyOnwer() {
        require(msg.sender == owner, "Unauthorized");
        _;

        // _; after the require statement means 'run the rest of the code after the require statement'.
        // _; before the require statement means 'run the rest of the code before the require statement'.
        // Underscore is a special character used inside modifiers
        // Which tells Solidity to execute the function the modifier is used on
        // at this point
    }

    function createToken() public onlyOnwer {
        // run the rest of the code;
    }

    /*
    Instead of writing the code repeatedly, and to prevent having code duplication.
    We can just call the modifier function on every function we want to use that modifier.
    */
}

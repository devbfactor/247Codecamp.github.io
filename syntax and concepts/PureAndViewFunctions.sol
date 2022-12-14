//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ViewAndPureFunction {
    uint256 y;

    // View function is a function that READS from state, but does not write to state.
    function getY() public view returns (uint256) {
        return y;
    }

    /*
    Basically 'getY' function will return the state variable 'y', but it will not make any change with that state variable. 
    */

    // Pure function is a function that DOES NOT READ or WRITE to State.
    function addTwoNumbers(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    /* 
    The 'addTwoNumbers' function will return the sum of 'uint256 a' and 'uint256 b' but it does not change anything or read anything from the state.
    The value will be coming fron the input.
    */

    // IMPORTANT: Both view and pure functions will not cost you gas
}

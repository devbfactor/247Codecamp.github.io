// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint) {
        uint z = x + y;

        require(z >= x, "overflow happened");
        require(y >= y, "overflow happened");
        return z;
    }

}

contract Libraries {
    /**
     * 3 top-level consturcts in Solidity
     *
     * 1. Contract
     * 2. Interface
     * 3. Library
     *
     * What is a Solidity Library?
     * - Typically used to add some helper functions to your contracts.
     * - They cannot contain any state
     * 1. You cannot have state variables
     * 2. You cannot have mapping/arrays/structs etc
     * 3. All you can do is have some functions that take some input and return some output
     *
     * Before Solidity 0.8.0, a very common library that was used was called 'SafeMath' which used to ensure
     * all mathemtical operations were 'valid' and there was no integer underflow/ overflow going on.
     *
     * Integer Overflow Example
     *
     * Imagine you have a uint8. It can hold valudes from 0 to (2 ^ 8) - 1;
     * which means, 0 to 255
     *
     * uint8 a = 254;
     * uint8 b = 5;
     * uint8 c = a + b;
     *
     * a + b = 259, but uint8 can only store value 0 to 255, which exceeds the maximum value.
     * the value of C after this statement would be 4 but you expected it to be 259 because it will circle back to 0;
     */


    function testAddition(uint x, uint y) public pure returns (uint) {
        return SafeMath.add(x, y);
    }
}

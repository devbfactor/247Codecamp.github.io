//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * Inheritance is the way that one contract can 'inherit' all the attributes (variables) and methods (functions) of any other contracts.
 *
 * In Solidity, we perform inheritance using the 'is' keyword.
 *
 * Solidity supports multiple inheritance, where your contract can inherit from other contract.
 *
 * A child contract can OVERRIDE a parent contract's function using the 'override' keyword in solidity.
 *
 * But only functions marked as 'virtual' are the only ones that can be over written.
 * other function CANNOt be overriden by the child.
 *
 * ORDER of inheritance MATTERS.
 *
 */

// Top levl parent contract
// virtual keywords marks this function to be able to be overridden by children function.
contract A {
    function foo() public pure virtual returns (string memory) {
        return "contract A";
    }
}

// B inherits A
contract B is A {
    // Override A.foo()
    // When we call function 'foo() on contract B, it will return the string "Contract B" because of the override keyword;
    // But if we remove the function foo() while keeping the contract B, it will return "contract A" because contract B 'is' coming from
    // contract A.
    function foo() public pure virtual override returns (string memory) {
        return "contract B";
    }
}

// C inherits A
contract C is A {
    // function is both virtual and override
    // meaning that keyword 'virtual' allows other function to override contract C
    // and that the override keyword will return contract A if there's no function inside the contract.
    function foo() public pure virtual override returns (string memory) {
        return "contract C";
    }
}

// D inherits from BOTH contract B and C
contract D is A, C {
    function foo() public pure virtual override(A, C) returns (string memory) {
        // super - is a special keyword that let's you call your parents functions. The lates contract that is called will be return
        // Order of inheritance is from left to right, this contract will return "contract C".
        return super.foo();
    }
}

contract E is C, B {
    function foo() public pure override(C, B) returns (string memory) {
        // This will return "contract B"
        return super.foo();
    }
}

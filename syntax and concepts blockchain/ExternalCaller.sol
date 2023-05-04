//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IMinimalERC20 {
    // we just need to include function definitions for the functions we care about.
    // we don't need an interface for the ENTIRE contract if we are not using those
    function balanceOf(address account) external view returns (uint256);

    function name() external view returns (string memory);
}

contract ExternalCaller {
    /**
     * Contracts can call other contracts by calling functions regularly on an instance of the other contract.
     *
     * If you are contract B, and you want to call the function foo() on contract A you can basically do A.foo();
     * But, to do this,
     * you need an interface for A.
     *
     * What is an interface?
     * -> An interface is kind of like an ABI to contract.
     * -> It defines function declarations.
     *  1. What is the name of the funciton present in this contract.
     *  2. What are the input values.
     *  3. What is the return value.
     *  4. What is the visibilitiy (public/ private/ external/ internal);
     *  5. What is the mutability (view, pure, nothing);
     *
     */

    IMinimalERC20 externalContract;  

    constructor(address someERC20Contract) {
        externalContract = IMinimalERC20(someERC20Contract);
    }

    function doIHaveBalance() public view {
        // 1. Check if msg.sender owns any ERC20 tokens from ERC20Contract;
        // 2. Require that the balance is greater than 0, otherwise fail the tx.

        uint balance = externalContract.balanceOf(msg.sender);
        require(balance > 0, "Failure, you don't have enough tokens");
    }

    function getERC20name() public view returns (string memory) {
        return externalContract.name();
    }
}

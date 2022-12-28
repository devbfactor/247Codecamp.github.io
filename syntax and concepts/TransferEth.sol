// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ETHsender {
    // Three different ways to send ETH from a contract
    // Reason for having three different methods is basically Solidity got upgraded over the years
    // 2 of the 3 methods are no longer recommended to use

    // Recommended is the .call method
    // function mirror takes in some ETH and sends it back to the person
    // The payable keyword is used in the function declaration to indicate that the function can receive Ether as an argument.
    function mirror() public payable {
        //msg.sender is the person we are getting the ETH from and also the person we send it back to

        //msg.value is the amount of ETH we receive, and amount we send back

        address payable target = payable(msg.sender);
        uint256 amount = msg.value;

        // this function is define on address - (payable.address).call{ value: amount}("");
        // .call() returns two variables
        // 1. Boolean indicating success or failure.
        // 2. Bytes which have data, it will only return if you sent some data.

        // This is how to accept multiple return values from a function;
        // (bool success, bytes memory data) = target.call{value: amount}("");
        (bool success, ) = target.call{value: amount}("");

        require(success, "Failure");
    }
}

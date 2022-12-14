//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Enums {
    /*
    Enums is short for enumerators.
    Enums are a way to restrict a variable's value to a predefined set of a possible
    option while maintaining human readability and ease of use.
     */

    enum Status {
        Single,
        Dating,
        In_a_relationship,
        Married,
        Widdowed
    }

    // Declaring a variable with data type status.
    Status status;

    // Since enums are internally represented by uints
    // This function will always return a uint
    // Single = 0
    // Dating = 1
    // In_a_relationship = 2
    // Married = 3
    // Widowed = 4
    // Value higher than 4 cannot be returned
    function getStatus() public view returns (Status) {
        return status;
    }

    // We will pass a uint for input to set the value
    function setStatus(Status _status) public {
        status = _status;
    }

    // We will update a value to a specific enum
    function marriedStatus() public {
        status = Status.Married; // This will return 3
    }
}

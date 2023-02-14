//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Structs {
    // Structs are way to hold a bunch of related information from them without any methods on them.
    // Structs works better for gas because it groups together related information which helps comipling to make a lot easier.

    struct TodoItem {
        uint256 id;
        string text;
        bool completed;
    }

    // Here we are mapping the struct 'TodoItem' and assigning a key uint256 which will be called todos.
    // We will be able to target the specific struct using the uint256 key => value pair.
    mapping(uint256 => TodoItem) todos;

    function createTask(
        uint256 _id,
        string memory _text,
        bool _completed
    ) public {
        todos[_id] = (TodoItem({id: _id, text: _text, completed: _completed}));
    }

    /* 
    This function creates a Task with 3 parameters of 'uint256 _id', 'string memory _text' & 'bool _completed'. 
    The function is set to public to access externally.
    The function will provide data for TodoItem struct, where these struct will have a key pair uint256 for todos mapping.
    */

    function getTodo(uint256 id) public view returns (TodoItem memory) {
        return todos[id];
    }
    /*
    Once we have successfully created a Task using the 'createTask function', we can return/ retrive that struct by 
    calling the assigned uint256 id.
    */
}

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Mapping {
    /*
    Map is a data structure where you have a key and a value.
    Mapping can be contrast to Arrays. Arrays have list of items/indexes,
    but what if you want to give names on those items/indexes.
    Mapping can provide a specific names or what we call key into those items, and those items we can call values.
    Instead of targeting the index number of a certain item, 
    you can set a key specific for that item, and use that key to manipulate the value.
    */

    //mapping (keyValue => value)

    mapping(address => string) public moods;

    /* 
    This tells that 'moods' has a bunch of items in it, 
    and we can access someone's moods value doing something like
    moods[0xABCDEF...] => string;
    */

    function getMood(address _user) public view returns (string memory) {
        return moods[_user];
    }

    /* This basically tells that 'getMood' function has one parameter - address of user.
    This function can be viewed only by everyone (public).
    This function will returns a value of string data type.
    The string data type that it will return is the mood of the address that was set.*/

    function setMood(string memory _mood) public {
        moods[msg.sender] = _mood;
    }

    /* 
    This function basically tells that 'setMood' function has one parameter - a string data type which we called _moood.
    This function can be access by everyone.
    What this function did, the value we set parameter _mood is assigned to the address of the msg.sender.
    Msg.sender is the address that will call this function.
    */
}

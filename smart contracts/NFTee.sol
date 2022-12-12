// SPDX-License-Identifier: MIT

//Telling ethereum which Solidity version to use when running this code
pragma solidity ^0.8.4;

//this imports the standard implementaion of ERC721
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//variables inside the contract are State Variables
//variables available only in the function are Local Variables
//variables which exist in global workspace

// Contract 'NFTee' _is_ an 'ERC721' contract
contract NFTee is ERC721 {
    //constructor gets called when deployed the contract for the first time
    constructor() ERC721("LearnWeb3's NFT", "LEARN-NFT") {
        //Mint 5 NFTs to myself
        //it is a convention to prefix function names with an underscore if they are private functions
        _mint(msg.sender, 1);
        _mint(msg.sender, 2);
        _mint(msg.sender, 3);
        _mint(msg.sender, 4);
        _mint(msg.sender, 5);
    }
}

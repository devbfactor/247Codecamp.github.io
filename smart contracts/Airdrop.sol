// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Airdrop {
    /**
     * @dev This line declares an array called 'recipients' with the variable type 'address[]'.
     * The private keyword indicates that this variable has the 'private' visibility and can be accessed from within the contract where it is defined.
     */
    address[] private recipients = [
        0x569F3eDA6852BD9F0C9930143e58cBb669e387b9,
        0x11833EB2C061588301f0988D8E0fbeB52156b688,
        0xdc64e572871B619857575E3a6e852339DF8875DA,
        0x23cbD81a957E032324C51CA674ea7de2376cdC2c
    ];

    /**
     * @dev this line of code declares a vriable 'airdropAmount' with the data type of uint256.
     * The private keyword indicates that this variable has the 'private' visibility and can be accessed from within the contract where it is defined.
     * The airdropAmount is set to value 0.2 ether.
     */
    uint256 private airdropAmount = 0.2 ether;

    // Define a mapping to track the amount of BNB already airdropped to each recipient
    mapping(address => uint256) private airdropped;

    //1,000,000,000 Gwei = 1 ETH

    constructor() payable {
        startAirdrop();
    }

    // Define a public function to initiate the airdrop
    function startAirdrop() public payable {
        // Iterate over the recipients array and airdrop the specified amount of ETH to each address
        for (uint256 i = 0; i < recipients.length; i++) {
            payable(recipients[i]).transfer(airdropAmount);
        }
    }
}

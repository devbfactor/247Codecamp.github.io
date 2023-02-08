// SPDX-License-Identifier: MIT

//Solidity version to use when running the code
pragma solidity ^0.8.4;

//This imports the standard implementation contracts
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Basically this means that Contract 'SimpleToken' _is_ an 'ERC20' && 'Ownable' contract
contract SimpleToken is ERC20, Ownable {
    /* This means we will be using the constructor function from 
    'ERC20' contract with its 2 parameters for Token Name and Token Symbol.
    All two of these values are immutable: they can only be set once during
    construction. */
    constructor() ERC20("SimpleToken", "SMP") {
        /*We will use the _mint function from the ERC20 contract.
        _mint function has two parameters, the address where to assign the tokens once minted
        and the amount of tokens in decimals.
        This _mint function will be called as soon as the contract is deployed.
        */
        _mint(msg.sender, 100 * 10 ** 18); //1 Billion Tokens
    }

    /*mint function creates `amount` tokens and assigns them to `account`, 
    increasing the total supply. */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

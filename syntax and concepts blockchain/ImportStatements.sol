// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// This is Local import
import "./Inheritance.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// This is external import
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

/**
 * There are 2 kinds of imports:
 * 1. Local Import
 * 2. External Import
 *
 * When using Hardhat, we use Openzepplin contracts, but we don't import them externally.
 *
 * We download openzepplin contracts as a node package through npm
 * npm install @openzeppelin/contracts
 *
 * import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; - This is example of local import.
 * When you download npm packages, they go into your 'node_modules' folder, you're just importing files from the 'node_modules'
 * folder.
 *
 *
 * */

// hardhat comes a built-in support for ethers.js
// ethers.js is a library to work with ethereum

//import ethers
const hre = require("hardhat");

async function main() {
  //1. Tell the script we want to deploy the 'NFTee.sol' contract
  const contract = await hre.ethers.getContractFactory("NFTee");

  //2. Deploy the contract
  const deployedContract = await contract.deploy();
  //2.1 wait for the deployment to finish.
  await deployedContract.deployed();

  //3. Print the address of the deployed contract
  console.log("NFT Contract deployed to: ", deployedContract.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  })
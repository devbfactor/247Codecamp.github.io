const { ethers } = require("hardhat");
require("dotenv").config({path: ".env"});
const { WHITELIST_CONTRACT_ADDRESS,  METADATA_URL } = require("../constants");

async function main() {

  const whitelistContract = WHITELIST_CONTRACT_ADDRESS;
  const metadataURL = METADATA_URL;
  const cryptoDevsContract = await ethers.getContractFactory("CryptoDevs");
  const deployedCryptoDevsContract = await cryptoDevsContract.deploy(metadataURL, whitelistContract);

  console.log(`The CryptoDevs Contract Address is ${deployedCryptoDevsContract.address}`);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })

// The CryptoDevs Contract Address is 0x3f6CDf65D52263A8FEa224C50fD01f3F6e5c9996
// https://goerli.etherscan.io/address/0xB07C796131B932D3dd529d21078D66Da618c536c#code

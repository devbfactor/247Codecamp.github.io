// importin the module for dotenv and @nomicfoundation/hardhat-toolbox
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

// initializing the QUICKNODE_HTTP_URL and PRIVATE_KEY coming from the .env file
// IMPORTANT: DO NOT SHARE THE PRIVATE KEY and HTTP_URL, these information are confidential and must be stored inside
// env only. 
const QUICKNODE_HTTP_URL = process.env.QUICKNODE_HTTP_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY

// This means we are exporting the solidity version, networks and private key.
module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      url: QUICKNODE_HTTP_URL,
      accounts: [PRIVATE_KEY],
    }
  }
}

// contract address: 0x7C6070cF5aC5213fa740Ea0370EFc930cb605A25
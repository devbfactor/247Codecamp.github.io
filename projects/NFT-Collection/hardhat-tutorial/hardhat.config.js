require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const QUICKNODE_HTTP_URL = process.env.QUICKNODE_HTTP_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      url: QUICKNODE_HTTP_URL,
      accounts: [PRIVATE_KEY],
    },
    mumbai: {
      url: process.env.MUMBAI_ALCHEMY_HTTP_URL,
      accounts: [PRIVATE_KEY],
    },

    // The CryptoDevs Contract Address is 0xa1A84C0685503616d440bfAfDC8b287B3eF17F0d
    // 
  },
  etherscan: {
    apiKey: {
      goerli: process.env.API_KEY,
    },
    apiKey: process.env.MUMBAI_API_KEY
  },
};

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** 
 * @type import('hardhat/config').HardhatUserConfig 
 */

module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      // How do we define which test network to deploy to?
      url: process.env.ALCHEMY_API_KEY_URL,
      // How do we define account to use for deployment?
      accounts: [process.env.PRIVATE_KEY],
    }
  }
};

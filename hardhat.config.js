require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();
require("@nomiclabs/hardhat-etherscan");
const rpcKey=process.env.RPC_KEY;
const pvtKey=process.env.PVT_KEY;


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    goerli:{
      url:`https://eth-goerli.g.alchemy.com/v2/${rpcKey}`,
      accounts:[pvtKey]
    }
  },
  etherscan: {
    apiKey: process.env.API_KEY
  },
}


const hre = require("hardhat");

async function main() {
  

  const ItemManager = await hre.ethers.getContractFactory("ItemManager");
  const itemManager = await ItemManager.deploy();

  await itemManager.deployed();

  console.log(
    `Contract is deployed to address:  ${itemManager.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

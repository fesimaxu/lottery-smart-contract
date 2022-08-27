import { ethers } from "hardhat";

async function main() {
  
  const [deployer] = await ethers.getSigners();
  console.log(`Address deploying the contract --> ${deployer.address}`);

  const lotteryAmount = ethers.utils.parseEther("1");

  const lottery = await ethers.getContractFactory("Lottery");
  const Lottery = await lottery.deploy("0x2DBdd859D9551b7d882e9f3801Dbb83b339bFFD7",lotteryAmount);

  await Lottery.deployed();

  console.log("Vault of 1 ETH deployed to:", Lottery.address);

  let result = await Lottery.lottery();

  let response = (await result.wait());

 console.log("factory cloned successfully", response);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

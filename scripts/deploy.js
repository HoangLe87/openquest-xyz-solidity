const hre = require("hardhat");

const main = async () => {
  const contractName = "SmartBankAccount";
  const contractFactory = await hre.ethers.getContractFactory(contractName);
  const contract = await contractFactory.deploy();
  await contract.deployed();
  console.log(`${contractName} deployed to address: ${contract.address}`);
  console.log("=== TESTS ===");
  console.log(String(await contract.getContractBalance()));
  console.log("=== ADDING 10000000 ===");
  contract.addMoneyToContract({ value: 1000000000 });
  console.log("=== DEPOSITING ===");
  await contract.addBalance({ value: 1000000 });
  console.log(String(await contract.getContractBalance()));
  console.log(
    "contract balance: ",
    String(await contract.getContractBalance())
  );
  console.log("=== WITHDRAWING ===");
  await contract.withdraw();
  console.log("balance: ", await contract.getContractBalance());
};

const runMain = (async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(0);
  }
})();

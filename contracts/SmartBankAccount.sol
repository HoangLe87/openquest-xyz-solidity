// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface cETH {
    function mint() external payable;

    function redeem(uint256 redeemTokens) external returns (uint256);

    function exchangeRateStored() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);
}

contract SmartBankAccount {
    uint256 totalContractBalance = 0;
    address payable owner;
    cETH ceth = cETH(0x64078a6189Bf45f80091c6Ff2fCEe1B15Ac8dbde);

    constructor() {
        owner = payable(msg.sender); // setting the contract creator
    }

    function getContractBalance() public view returns (uint256) {
        return totalContractBalance;
    }

    mapping(address => uint256) balances;
    mapping(address => uint256) depositTimestamps;

    function addBalance() public payable {
        balances[msg.sender] = msg.value;
        totalContractBalance = totalContractBalance + msg.value;
        depositTimestamps[msg.sender] = block.timestamp;
    }

    function getBalance(address userAddress) public view returns (uint256) {
        return (ceth.balanceOf(userAddress) * ceth.exchangeRateStored()) / 1e18;
    }

    function withdraw() public payable {
        address payable withdrawTo = payable(msg.sender);
        uint256 amountToTransfer = getBalance(msg.sender);
        (bool sucess, ) = withdrawTo.call{value: amountToTransfer}("");
        require(sucess, "failed to withdraw");
        totalContractBalance = totalContractBalance - amountToTransfer;
        balances[msg.sender] = 0;
    }

    function addMoneyToContract() public payable {
        totalContractBalance += msg.value;
    }

    receive() external payable {}

    fallback() external payable {}
}

pragma solidity ^0.8.0;

contract TimeLockedSavingsAccount {
   address payable public owner;
   uint public unlockTime;
   uint public balance;

   constructor() payable {
      owner = payable(msg.sender);
      unlockTime = block.timestamp + 365 days; //Set to 1 year from now
      balance = msg.value;
   }

   modifier onlyOwner() {
      require(msg.sender == owner, "Only the owner can withdraw funds.");
      _;
   }

   modifier onlyAfterUnlockTime() {
      require(block.timestamp >= unlockTime, "Funds cannot be withdrawn yet.");
      _;
   }

   function deposit() public payable {
      balance += msg.value;
   }

   function withdraw() public onlyOwner onlyAfterUnlockTime {
      owner.transfer(balance);
      balance = 0;
   }

   function getBalance() public view returns (uint) {
      return balance;
   }
}

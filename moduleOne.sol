// SPDX-License-Identifier: MIT
// Compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.17;

contract FriendlyEscrow {
    address public payer;
    address public payee;
    uint256 public lockedAmount;    //STORE AMOUNT OF ETHER THAT IS LOKED IN ESCROW
    bool public paymentCompleted;

    event EscrowSetup(address indexed payer, address indexed payee, uint256 amount);
    event FundsTransferred(address indexed to, uint256 amount);
    event EscrowAborted(string message);

    // INITIALIZE THE CONTRACT
    constructor(address _payer, address _payee) {
        payer = _payer;
        payee = _payee;
        paymentCompleted = false;
    }

    function depositFunds() external payable {
        require(msg.sender == payer, "Only the payer can deposit funds.");
        require(msg.value > 0, "Please deposit a non-zero amount.");
    
        lockedAmount = msg.value;          //AMOUNT OF ETHER SEND IN TRANSACTION 
        emit EscrowSetup(payer, payee, lockedAmount);
    }

    // Function to release funds 
    function releasePayment() external payable  {
        require(msg.sender == payer, "Only the payer can authorize the release of funds.");
        require(!paymentCompleted, "The funds have already been released.");
        require(address(this).balance >= lockedAmount, "Contract does not have enough balance to cover the payment.");

        assert(address(this).balance == lockedAmount);

        paymentCompleted = true;
        payable(payee).transfer(lockedAmount);
        emit FundsTransferred(payee, lockedAmount);
    }

    function abortEscrow() external view {
        require(msg.sender == payer, "Only the payer can cancel the escrow.");
        require(!paymentCompleted, "Cannot cancel the escrow after the payment has been released.");

        revert("Escrow has been canceled by the payer. All funds will remain in the contract.");
    }
}

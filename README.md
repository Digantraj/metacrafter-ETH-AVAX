# FriendlyEscrow Smart Contract

This project demonstrates a simple smart contract implementation called **FriendlyEscrow** using Solidity. The contract is designed to handle escrow payments between two parties, the payer and the payee. It utilizes Solidity's `require()`, `assert()`, and `revert()` statements to ensure proper execution flow and error handling.

## Features

- **Deposit Funds:** The payer can deposit a specific amount of Ether into the contract.
- **Release Payment:** The payer can release the locked funds to the payee once certain conditions are met.
- **Abort Escrow:** The payer can cancel the escrow under specific conditions.

## Prerequisites

- **Solidity Version:** This contract requires a Solidity compiler version greater than or equal to 0.8.17 and less than 0.9.0.

## Contract Overview

### Variables

- `payer`: The address of the payer.
- `payee`: The address of the payee.
- `lockedAmount`: The amount of Ether locked in the escrow.
- `paymentCompleted`: A boolean indicating whether the payment has been completed.

### Events

- `EscrowSetup(address indexed payer, address indexed payee, uint256 amount)`: Emitted when the escrow is set up.
- `FundsTransferred(address indexed to, uint256 amount)`: Emitted when funds are transferred to the payee.
- `EscrowAborted(string message)`: Emitted when the escrow is aborted.

### Functions

- **`constructor(address _payer, address _payee)`**: Initializes the contract with the payer and payee addresses.

- **`depositFunds() external payable`**: Allows the payer to deposit funds into the contract. Uses `require()` to ensure that only the payer can deposit and that the deposit amount is greater than zero.

- **`releasePayment() external payable`**: Releases the locked funds to the payee. Uses `require()` to ensure only the payer can authorize the release, that the payment has not already been completed, and that the contract has enough balance. Uses `assert()` to confirm the contract's balance matches the locked amount before proceeding.

- **`abortEscrow() external view`**: Allows the payer to abort the escrow. Uses `require()` to ensure only the payer can abort and that the payment has not been completed. Uses `revert()` to cancel the transaction and provide a message.

## Example Usage

```solidity
// Deploying the contract
FriendlyEscrow escrow = new FriendlyEscrow(payerAddress, payeeAddress);

// Payer deposits funds
escrow.depositFunds{value: amountInWei}();

// Releasing payment to payee
escrow.releasePayment();

// Aborting the escrow (if necessary)
escrow.abortEscrow();
```

## Error Handling

The smart contract implements three types of error handling mechanisms:

1. **`require()`**: 
   - Used to validate conditions before execution. 
   - If the condition fails, the transaction is reverted with an optional error message. 
   - Commonly used to check inputs, state variables, and return values from external function calls.

2. **`assert()`**: 
   - Used to check for conditions that should never fail. 
   - If the condition fails, it indicates a bug in the code, and the transaction is reverted, consuming all remaining gas.
   - Primarily used to check for internal errors and invariants.

3. **`revert()`**: 
   - Explicitly reverts the transaction and provides a custom error message. 
   - Can be used to undo all state changes made during the transaction up to the point of failure.
   - It is useful when complex conditions need to be validated, or multiple require checks need to be consolidated into a single error state.

## Authors

- **Digant Raj**  
  GitHub: [@Digant](https://github.com/Digantraj)

## License

This project is licensed under the MIT License.


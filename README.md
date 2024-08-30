# EduSystem Smart Contract

## Overview

The `EduSystem` smart contract is a Solidity-based contract designed for managing learners and academic programs in a decentralized system. It allows an admin to register learners, create programs, enroll learners in programs, and assign scores. Learners can check their registration status, program enrollment status, and their scores.

## Features

- **Admin Functions:**
  - Register new learners.
  - Create new academic programs.
  - Assign scores to learners for specific programs.
  - Prevent unauthorized access with a revert mechanism.

- **Learner Functions:**
  - Enroll in academic programs.
  - Check registration status.
  - Check enrollment status.
  - Retrieve scores for enrolled programs.

## Contract Functions

### Admin Functions

1. **`addLearner(address _learnerAddress, uint256 _id, string memory _fullName)`**
   - Registers a new learner with the specified address, ID, and name.

2. **`createProgram(uint256 _id, string memory _title)`**
   - Creates a new academic program with the specified ID and title.

3. **`setScore(address _learnerAddress, uint256 _programId, uint8 _score)`**
   - Assigns a score to a learner for a specific program. Only the admin can call this function.

4. **`preventUnauthorized()`**
   - Demonstrates the use of the `revert` function to prevent unauthorized access.

### Learner Functions

1. **`enroll(uint256 _programId)`**
   - Enrolls the caller in the specified academic program.

2. **`checkRegistration(address _learnerAddress)`**
   - Returns whether the specified address is registered as a learner.

3. **`checkEnrollment(address _learnerAddress, uint256 _programId)`**
   - Returns whether the specified learner is enrolled in the given program.

4. **`getScore(address _learnerAddress, uint256 _programId)`**
   - Returns the score of the specified learner for the given program.

## Deployment Using Remix IDE

1. **Open Remix IDE:**
   - Navigate to [Remix IDE](https://remix.ethereum.org/).

2. **Load the Contract:**
   - Create a new file in the Remix IDE and paste the Solidity code for `EduSystem`.

3. **Compile the Contract:**
   - Select the "Solidity Compiler" tab on the left sidebar.
   - Ensure the correct Solidity version (0.8.x) is selected.
   - Click the "Compile EduSystem.sol" button.

4. **Deploy the Contract:**
   - Switch to the "Deploy & Run Transactions" tab.
   - Ensure "JavaScript VM" is selected as the environment for testing or connect to an appropriate network (e.g., Injected Web3 with MetaMask).
   - Click the "Deploy" button to deploy the contract.

5. **Interact with the Contract:**
   - Once deployed, the contract instance will appear in the "Deployed Contracts" section.
   - Use the contract's functions through the Remix interface to interact with it.

## Testing

- **Manual Testing:**
  - Use Remix's UI to test each function. Check that you can perform operations as expected and that events are emitted correctly.

## License

This project is licensed under the MIT License.

## Authors

- **Digant Raj**  
  GitHub: [@Digant](https://github.com/Digantraj)


# Solidity Smart Contract: Understanding require(), assert(), and revert()

## Overview

This repository contains a simple Solidity smart contract that demonstrates the usage of `require()`, `assert()`, and `revert()` statements. These statements are essential for enforcing preconditions, validating internal state, and handling exceptional cases in smart contract development.

## Requirements

To interact with the smart contract, you'll need:
- A development environment for Ethereum smart contracts (e.g., Remix, Truffle, Hardhat)
- An Ethereum wallet or client (e.g., MetaMask) to deploy and interact with the contract on a testnet or mainnet

## Usage

1. Clone this repository to your local machine:
https://github.com/pauljustine024/Functions-and-Errors-Project
2. Navigate to the project directory:
   cd solidity-assertions

3. Open the `RequireAssertRevert.sol` file in your preferred Solidity development environment.

4. Compile the smart contract.

5. Deploy the smart contract to your desired Ethereum network (testnet or mainnet).

6. Interact with the deployed contract using the provided functions, such as `setNumber()`.

## Code Explanation

- `require()`: Used to enforce conditions that must be met for a function to execute successfully. It helps validate inputs and prevent invalid state changes.
- `assert()`: Checks for internal errors and invariant violations within the contract. It's crucial for ensuring the integrity of the contract's state.
- `revert()`: Reverts a transaction with a specified error message. It's useful for handling exceptional cases and aborting transactions when certain conditions aren't met.

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

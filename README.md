# Project Title
Degen Token (ERC-20): Unlocking the Future of Gaming

## Description
A Solidity smart contract for Degen Token (DGN), an ERC-20 token that facilitates transactions and unique features for the gaming community.

## Getting Started
Follow these steps to set up and deploy the contract.

### Prerequisites
- [Node.js](https://nodejs.org/) installed
- [Metamask](https://metamask.io/) for interacting with the Avalanche testnet

### Installation
1. Fork the [GitHub repository](https://github.com/Metacrafters/DegenToken) for convenience. It is already configured to work with Avalanche.
2. Ensure Node.js is installed in your workspace.
3. Open the terminal and run:
    ```bash
    npm i
    ```
    This installs all the project dependencies.

4. Copy and paste the provided Solidity code in this directory `DegenToken.sol` into the contract file in the contracts folder.

## Deploying the Contract
To deploy the contract, you need a Snowtrace API key, a Metamask private key, and testnet AVAX for deployment.

### Acquiring the Snowtrace API
Create a free account on [Snowtrace](https://snowtrace.io/) and follow the [official guide](https://docs.snowtrace.io/getting-started/viewing-api-usage-statistics) to get your API key.

### Acquiring the Metamask Private Key
1. Download and install [Metamask](https://metamask.io/download/).
2. In Metamask, export your private key:
   - Click on the account selector at the top.
   - Click the three vertical dots next to the account.
   - Click 'Show private key,' enter your password, and save the private key.

### Getting AVAX from the Faucet
Visit the [AVAX Faucet](https://core.app/tools/testnet-faucet/?subnet=c&token=c), connect your wallet, and request AVAX.

### Deploying the Contract
1. Create a `.env` file in your project folder and add your keys:
    ```
    WALLET_PRIVATE_KEY=*your_wallet_private_key
    SNOWTRACE_API_KEY=*your_api_key
    ```

2. Deploy the contract using:
    ```bash
    npx hardhat run scripts/deploy.js --network fuji
    ```

3. Verify the contract on Fuji:
    ```bash
    npx hardhat verify <YOUR_TOKEN_ADDRESS> --network fuji
    ```

4. Check your contract on [Snowtrace](https://testnet.snowtrace.io/).

## Testing the Contract
To test the contract, use [Remix IDE](https://remix.ethereum.org/):

1. Copy the Solidity code into a new file.
2. Select the appropriate compiler version, preferably **0.8.20** or above.
3. Compile the code by navigating to the Solidity Compiler tab in the left sidebar. Ensure that the selected compiler version is correct.
4. Once compiled, go to the Deploy & Run Transactions tab.
5. In the 'At Address' section, paste the deployed contract address and click the 'At Address' button to deploy it.

Now, your smart contract is ready for testing in Remix.


## Author
Mark Revin Fragata

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

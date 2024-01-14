# Assignment 1 : Token Sale Smart Contract

1. **Build:**

   ```bash
   forge build
   ```

2. **Test:**

   ```bash
   forge test
   ```

## Contract Overview

The `TokenSale` contract extends the ERC-20 standard and introduces functionality for conducting a token sale with pre-sale and public sale phases. The contract allows contributors to participate in the sale, minting tokens in exchange for ether. The sale is divided into two phases: pre-sale and public sale, each with specific caps and contribution limits.

## Variables

- **`owner`**: Address of the contract owner.
- **`pre_maxcap`**: Maximum cap for the pre-sale phase.
- **`pre_mincontri`**: Minimum contribution allowed in the pre-sale phase.
- **`pre_maxcontri`**: Maximum contribution allowed in the pre-sale phase.
- **`pre_totalcap`**: Total ether contributed in the pre-sale phase.
- **`pub_maxcap`**: Maximum cap for the public sale phase.
- **`pub_mincontri`**: Minimum contribution allowed in the public sale phase.
- **`pub_maxcontri`**: Maximum contribution allowed in the public sale phase.
- **`pub_totalcap`**: Total ether contributed in the public sale phase.
- **`isPublicSale`**: Boolean indicating whether the public sale has started.
- **`balance`**: Mapping to store the balance of each contributor.

## Constructor

The constructor initializes the ERC-20 token with the name "ALPHA" and symbol "ALP" and sets the initial values for the sale caps, contribution limits, and the contract owner.

## Functions

### `presale()`

- **Description**: Allows contributors to participate in the pre-sale phase by sending ether.
- **Error Handling**: Requires that the pre-sale is still ongoing, contribution is within limits, and the total cap is not exceeded.

### `endPreSale()`

- **Description**: Ends the pre-sale phase, allowing the public sale to begin.
- **Modifiers**: Requires that the caller is the owner.

### `pubSale()`

- **Description**: Allows contributors to participate in the public sale phase by sending ether.
- **Error Handling**: Requires that the public sale has started, contribution is within limits, and the total cap is not exceeded.

### `sendtoken(address _to, uint _amount)`

- **Description**: Allows the owner to send tokens to a specific address.
- **Modifiers**: Requires that the caller is the owner.

### `refund(uint _amount)`

- **Description**: Allows contributors to request a refund in case the sale cap is not reached.
- **Error Handling**: Checks if the contributor has a balance, the requested amount is within the balance, and the sale cap is not reached.
- **Note**: The contract uses the `_burn` function to decrease the balance and `_mint` to create tokens.

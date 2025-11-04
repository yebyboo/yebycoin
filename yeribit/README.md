# Yeribit Smart Contract (Clarinet)

A fungible token smart contract for the Yeribit token, built with Clarinet (Clarity on Stacks). It exposes SIP-010-compatible read-only functions and basic mint/transfer/burn operations.

## Features
- SIP-010 style getters: `get-name`, `get-symbol`, `get-decimals`, `get-total-supply`, `get-balance`, `get-token-uri`
- Public functions: `transfer`, `mint` (owner-only), `burn`, `set-token-uri` (owner-only), `set-owner` (owner-only)
- Uses Clarity built-ins `define-fungible-token`, `ft-transfer?`, `ft-mint?`, `ft-burn?`

## Project layout
- `contracts/yeribit-token.clar` – the smart contract
- `Clarinet.toml` – Clarinet project manifest registering the contract
- `settings/` – network configuration (Devnet/Testnet/Mainnet)
- `tests/` – ready for Vitest-based tests (optional)

## Prerequisites
- Clarinet CLI installed (v3+)
  - Check: `clarinet --version`
  - Install/Upgrade: see https://docs.hiro.so/clarinet

## Quick start
```bash
# From this directory
clarinet check
```
You should see the Clarity analyzer complete without errors.

## Dev console examples
Start the console:
```bash
clarinet console
```
Example session (using default `deployer` and `wallet_1` accounts):
```clarity
# Mint 1,000,000 micro-units (assuming 6 decimals) to wallet_1 (owner-only)
::contract-call? .yeribit-token mint wallet_1 u1000000

# Transfer 1000 units to wallet_2
::contract-call? .yeribit-token transfer wallet_2 u1000 none

# Check balances
::contract-call? .yeribit-token get-balance wallet_1
::contract-call? .yeribit-token get-balance wallet_2

# Burn 500 units from the caller
::contract-call? .yeribit-token burn u500
```

## Configuration
- Owner defaults to the deployer account at contract deployment time.
- Token metadata can be updated by the owner via `set-token-uri`.
- Default decimals: `6` (adjust in the contract if needed).

## Testing
```bash
npm install
npm test
```

## Deployment
Use Clarinet to generate and sign transactions or integrate with the Stacks CLI for on-chain deployment. Update `settings/*.toml` with deployment plans as needed.

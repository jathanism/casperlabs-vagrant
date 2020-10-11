#!/bin/bash

# Download and install Rust without any prompts
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Rust as the vagrant user
echo "Enabling Rust..."
source $HOME/.cargo/env

# Install Casperlabs and bootstrap it
echo "Setting up Casperlabs..."
cargo install cargo-casperlabs
cargo casperlabs my-project
cd my-project/contract
rustup install $(cat rust-toolchain)
rustup target add --toolchain $(cat rust-toolchain) wasm32-unknown-unknown

# Build the Contract
echo "Building the contract..."
cargo build --release

# Test the Contract
echo "Testing the contract..."
cd ../tests
cargo test

# Tests should have completed
figlet welcome to casperlabs

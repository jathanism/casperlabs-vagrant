#!/bin/bash

# Download and install Rust without any prompts
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -q -y

# Install Rust as the vagrant user
echo "Enabling Rust..."
source $HOME/.cargo/env

# Install Python client and reload .profile after
echo "Installing Python client..."
pip3 install --quiet casperlabs_client
source ~/.profile

# Install Casperlabs and bootstrap it
echo "Setting up Casperlabs..."
cargo install --quiet cargo-casperlabs
cargo --quiet casperlabs my-project
cd my-project/contract
rustup --quiet install $(cat rust-toolchain)
rustup --quiet target add --toolchain $(cat rust-toolchain) wasm32-unknown-unknown

# Build the Contract
echo "Building the contract..."
cargo build --release --quiet

# Test the Contract
echo "Testing the contract..."
cd ../tests
cargo test --color never --quiet

# Tests should have completed
figlet welcome to casperlabs

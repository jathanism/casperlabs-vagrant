#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "Updating system packages..."
# Update and cleanup apt first...
apt update
apt upgrade -y
apt autoremove --purge -y

echo "Installing build dependencies..."
# Then install our stuff
apt install -y build-essential cmake
apt install -y protobuf-compiler
apt install -y python3 python3-pip python3-dev
apt install -y figlet

# Download and install Rust without any prompts
echo "Installing Rust..."
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/install-rust.sh
chmod +x /tmp/install-rust.sh

# Install Rust as the vagrant user
echo "Enabling Rust..."
sudo su - vagrant
/tmp/install-rust.sh -y && source $HOME/.cargo/env

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

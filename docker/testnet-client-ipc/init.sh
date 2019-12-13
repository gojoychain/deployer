#!/bin/bash
# Init script for client node.

# Ensure DEPLOYER_DIR was set in env
if [ -z "$DEPLOYER_DIR" ]; then
    echo "DEPLOYER_DIR not found in env file"
    exit 2
fi

# Ensure DATA_DIR was set in env
if [ -z "$DATA_DIR" ]; then
    echo "DATA_DIR not found in env file"
    exit 2
fi

# Setup data dir
if [ ! -z "$DATA_DIR" ] && [ ! -d "$DATA_DIR" ]; then
    echo "Setting up data dir..."
    mkdir -p "$DATA_DIR"
fi

# Create genesis block
if [ ! -d "$DATA_DIR/geth/chaindata" ]; then
    echo "Init genesis block..."
    geth --datadir $DATA_DIR init /root/.joy/genesis.json
fi

# Copy static-nodes.json to data dir
echo "Copying static-nodes.json..."
cp /root/.joy/static-nodes.json "$DATA_DIR/geth"

echo "Node initialization finished!"

geth "$@"

#!/bin/bash
# Init script for client node.

echo "Node initialization started!"

# Ensure DEPLOYER_DIR was set in env
if [ -z "$DEPLOYER_DIR" ]; then
    echo "DEPLOYER_DIR not found in env file"
    exit 2
fi

# Create genesis block
if [ ! -d /root/.ethereum/geth/chaindata ]; then
    echo "Init genesis block..."
    geth init /root/.joy/genesis.json
fi

# Copy static-nodes.json to data dir
echo "Copying static-nodes.json..."
cp /root/.joy/static-nodes.json /root/.ethereum/geth

echo "Node initialization finished!"

geth \
--syncmode=full \
--gcmode=archive \
--networkid=$CHAIN_ID \
--nat=none \
--targetgaslimit=4700000 \
--port=$LISTEN_PORT \
--verbosity=4 \
--bootnodes=$BOOTNODES

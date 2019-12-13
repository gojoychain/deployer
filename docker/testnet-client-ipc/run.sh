#!/bin/sh
# Init script for Testnet Client IPC-only node.

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

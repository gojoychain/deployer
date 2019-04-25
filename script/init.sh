#!/bin/sh
# Initializes a new node
# Inject env args before calling script

# Make dir if needed
if [ ! -d "$DATA_DIR" ]; then
    echo "Creating datadir"
    mkdir -p "$DATA_DIR"
fi

# Create genesis block
echo "Init genesis block"
geth --datadir "$DATA_DIR" init "$GENESIS_FILE"

# Imports to the account to the datadir
if [ ! -z "$PW_FILE" ] && [ ! -z "$PRIV_KEY_FILE" ]; then
    echo "Importing account"
    geth --datadir "$DATA_DIR" account import --password "$PW_FILE" "$PRIV_KEY_FILE"
fi

# Copy static-nodes.json to data dir
echo "Copying static-node.json"
cp "$STATIC_NODE_FILE" "$DATA_DIR/geth"

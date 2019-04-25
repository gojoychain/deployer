#!/bin/sh
# Initializes a new node
# ./init-account.sh $DATA_DIR $GENESIS_FILE $PW_FILE $PRIV_KEY_FILE $STATIC_NODE_FILE

DATA_DIR=$1
GENESIS_FILE=$2
PW_FILE=$3
PRIV_KEY_FILE=$4
STATIC_NODE_FILE=$5

# Make dir if needed
if [ ! -d "$DATA_DIR" ]; then
    echo "Creating datadir"
    mkdir -p "$DATA_DIR"
fi

# Create genesis block
echo "Init genesis block"
geth --datadir "$DATA_DIR" init "$GENESIS_FILE"

# Imports to the account to the datadir
if [ $PW_FILE != "null" ] && [ $PRIV_KEY_FILE != "null" ]; then
    echo "Importing account"
    geth --datadir "$DATA_DIR" account import --password "$PW_FILE" "$PRIV_KEY_FILE"
fi

# Copy static-nodes.json to data dir
echo "Copying static-node.json"
cp "$STATIC_NODE_FILE" "$DATA_DIR/geth"

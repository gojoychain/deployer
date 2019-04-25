#!/bin/sh
# Initializes a new node
# ./init-account.sh $GENESIS_FILE $PW_FILE $PRIV_KEY_FILE $STATIC_NODE_FILE

DATADIR=$HOME/.ghu
GENESIS_FILE=$1
PW_FILE=$2
PRIV_KEY_FILE=$3
STATIC_NODE_FILE=$4

# Make dir if needed
if [ ! -d "$DATADIR" ]; then
    echo "Creating datadir"
    mkdir -p "$DATADIR"
fi

# Create genesis block
echo "Init genesis block"
geth --datadir "$DATADIR" init "$GENESIS_FILE"

# Imports to the account to the datadir
if [ $PW_FILE != "null" ] && [ $PRIV_KEY_FILE != "null" ]; then
    echo "Importing account"
    geth --datadir "$DATADIR" account import --password "$PW_FILE" "$PRIV_KEY_FILE"
fi

# Copy static-nodes.json to data dir
echo "Copying static-node.json"
cp "$STATIC_NODE_FILE" "$DATADIR/geth"

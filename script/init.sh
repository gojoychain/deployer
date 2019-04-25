#!/bin/sh
# Initializes a new node
# ./init-account.sh $GENESIS_FILE $PW_FILE $PRIV_KEY_FILE $STATIC_NODE_FILE

DATADIR=$HOME/.ghu
GENESIS_FILE=$1
PW_FILE=$2
PRIV_KEY_FILE=$3
STATIC_NODE_FILE=$4

# Make dir if needed
mkdir "$DATADIR"

# Create genesis block
geth --datadir "$DATADIR" init "$GENESIS_FILE"

# Imports to the account to the datadir
geth --datadir "$DATADIR" account import --password "$PW_FILE" "$PRIV_KEY_FILE"

# Copy static-nodes.json to data dir
cp "$STATIC_NODE_FILE" "$DATADIR/geth"

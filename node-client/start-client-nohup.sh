#!/bin/sh

# Create logs dir
if [ ! -d "$LOGS_DIR" ]; then
    echo "Creating logs dir"
    mkdir -p "$LOGS_DIR"
fi

# Start geth
nohup \
geth \
--datadir "$DATA_DIR" \
--syncmode full \
--gcmode archive \
--networkid "$CHAIN_ID" \
--nat=none \
--targetgaslimit 4700000 \
--rpc \
--rpcaddr 0.0.0.0 \
--rpccorsdomain "*" \
--rpcapi db,debug,eth,net,web3 \
--ws \
--wsaddr 0.0.0.0 \
--wsorigins "*" \
--wsapi db,debug,eth,net,web3 \
--verbosity 4 \
--bootnodes "$BOOTNODES"
>> "$LOGS_DIR/geth.log" &

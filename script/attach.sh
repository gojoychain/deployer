#!/bin/sh
# Attaches geth console to instance

MESSAGE="$ ./attach.sh [mainnet/testnet]"
NETWORK=$1

if [ "$NETWORK" = "mainnet" ]; then
    geth attach ipc:$HOME/.ghu/mainnet/geth.ipc
elif [ "$NETWORK" = "testnet" ]; then
    geth attach ipc:$HOME/.ghu/testnet/geth.ipc
else
    echo "Invalid network!"
    echo "$MESSAGE"
fi

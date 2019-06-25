#!/bin/sh

DIRECTORY=/root/.joy/geth

if [ ! -d "$DIRECTORY" ]; then
    echo "Datadir not found, exec geth init"
    geth --datadir /root/.joy init /root/.joy/genesis.json
fi
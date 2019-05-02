#!/bin/sh

DIRECTORY=/root/.ghu/geth

if [ ! -d "$DIRECTORY" ]; then
    echo "Datadir not found, exec geth init"
    geth --datadir /root/.ghu init /root/.ghu/genesis.json
fi
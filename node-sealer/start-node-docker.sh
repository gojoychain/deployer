#!/bin/sh

geth \
--datadir /root/.ghu \
--syncmode full \
--networkid "$CHAIN_ID" \
--nat=none \
--targetgaslimit 4700000 \
--rpc \
--rpcaddr "127.0.0.1" \
--rpccorsdomain "127.0.0.1" \
--verbosity 4 \
--mine \
--bootnodes "$BOOTNODES" \
--etherbase "$ETHERBASE_ADDRESS" \
--unlock "$ADDRESS" \
--password /root/.ghu/.accountpw
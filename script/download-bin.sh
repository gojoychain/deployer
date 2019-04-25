#!/bin/sh

CURRENT_VERSION=v1.8.23a

# Fetch geth binary
echo "Downloading geth"
wget "https://github.com/ghuchain/go-ghuchain-releases/releases/download/$CURRENT_VERSION/geth-linux-amd64"
mv geth-linux-amd64 geth
chmod 755 geth
sudo mv geth /usr/local/bin

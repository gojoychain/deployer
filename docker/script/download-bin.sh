#!/bin/sh
# Linux AMD64 arch type

CURRENT_VERSION=v1.8.23a

# Fetch geth binary
echo "Downloading geth"
wget "https://github.com/gojoychain/releases/releases/download/$CURRENT_VERSION/geth-linux-amd64"
mv geth-linux-amd64 geth
chmod 755 geth
sudo mv geth /usr/local/bin

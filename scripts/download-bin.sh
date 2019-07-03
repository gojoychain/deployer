#!/bin/sh
# Downloads, unzips, and moves bootnode and geth binaries to /usr/local/bin

CURRENT_VERSION=1.8.23a
UNZIP_DIR=/tmp/gojoy

echo "Downloading all geth tools..."
wget "https://github.com/gojoychain/releases/releases/download/v$CURRENT_VERSION/all-linux-amd64-$CURRENT_VERSION.tar.gz"
mkdir -p $UNZIP_DIR
tar xvzf "all-linux-amd64-$CURRENT_VERSION.tar.gz" -C $UNZIP_DIR
chmod 755 "$UNZIP_DIR/bootnode-linux-amd64"
chmod 755 "$UNZIP_DIR/geth-linux-amd64"
sudo mv "$UNZIP_DIR/bootnode-linux-amd64" /usr/local/bin/bootnode
sudo mv "$UNZIP_DIR/geth-linux-amd64" /usr/local/bin/geth
rm "all-linux-amd64-$CURRENT_VERSION.tar.gz"
echo "Finished!"

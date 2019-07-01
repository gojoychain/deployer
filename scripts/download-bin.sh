#!/bin/sh
# Downloads, unzips, and moves bootnode and geth binaries to /usr/local/bin

CURRENT_VERSION=1.8.23a
UNZIP_DIR=/tmp/gojoy

echo "Downloading all geth tools..."
wget "https://github.com/gojoychain/releases/releases/download/v$CURRENT_VERSION/geth-all-linux-amd64-$CURRENT_VERSION.tar.gz"
mkdir $UNZIP_DIR
tar xvzf "geth-all-linux-amd64-$CURRENT_VERSION.tar.gz" -C $UNZIP_DIR
chmod 755 "$UNZIP_DIR/bootnode"
chmod 755 "$UNZIP_DIR/geth"
sudo mv "$UNZIP_DIR/bootnode" /usr/local/bin
sudo mv "$UNZIP_DIR/geth" /usr/local/bin
rm "geth-all-linux-amd64-$CURRENT_VERSION.tar.gz"
echo "Finished!"

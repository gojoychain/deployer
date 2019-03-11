#!/bin/sh

MESSAGE="$ ./restore.sh [mainnet|testnet]"
MAINNET_CONTAINER="mainnet_mainnet-client-data"
MAINNET_BACKUP_PATH="/root/.ghu/mainnet/geth"
TESTNET_CONTAINER="testnet_testnet-client-data"
TESTNET_BACKUP_PATH="/root/.ghu/testnet/geth"

# Set network config
if [ $1 = "mainnet" ]; then
    VOLUME_NAME=$MAINNET_CONTAINER
    ORIGIN_PATH=$MAINNET_BACKUP_PATH
elif [ $1 = "testnet" ]; then
    VOLUME_NAME=$TESTNET_CONTAINER
    ORIGIN_PATH=$TESTNET_BACKUP_PATH
else
    echo "invalid network"
    echo ${MESSAGE}
    exit 2
fi

echo "Restoring volume: ${VOLUME_NAME}"
echo "Writing from: ${ORIGIN_PATH}"

# Get mountpoint path
docker volume inspect ${VOLUME_NAME} > volume.txt
MOUNTPOINT="$(jq -r '.[] | .Mountpoint' volume.txt)"
rm volume.txt

# Copy chaindata folders
sudo cp -r ${ORIGIN_PATH} "${MOUNTPOINT}/geth/chaindata" 
sudo cp -r ${ORIGIN_PATH} "${MOUNTPOINT}/geth/lightchaindata"

echo "Finished restoring volume ${VOLUME_NAME}"

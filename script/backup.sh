#!/bin/sh

MESSAGE="$ ./backup.sh [mainnet | testnet]"
MAINNET_CONTAINER="mainnet_mainnet-client-data"
MAINNET_BACKUP_DEST="/root/.ghu/mainnet/geth"
TESTNET_CONTAINER="testnet_testnet-client-data"
TESTNET_BACKUP_DEST="/root/.ghu/testnet/geth"

# Set network config
if [ $1 = "mainnet" ]; then
    VOLUME_NAME=$MAINNET_CONTAINER
    DEST_PATH=$MAINNET_BACKUP_DEST
elif [ $1 = "testnet" ]; then
    VOLUME_NAME=$TESTNET_CONTAINER
    DEST_PATH=$TESTNET_BACKUP_DEST
else
    echo "invalid network"
    echo ${MESSAGE}
    exit 2
fi

echo "Backing up volume: ${VOLUME_NAME}"
echo "Writing to: ${DEST_PATH}"

# Get mountpoint path
docker volume inspect ${VOLUME_NAME} > volume.txt
MOUNTPOINT="$(jq -r '.[] | .Mountpoint' volume.txt)"
rm volume.txt

# Make dirs if needed
sudo mkdir -p "${DEST_PATH}/chaindata"
sudo mkdir -p "${DEST_PATH}/lightchaindata"

# Cleanup old files
sudo rm -rf "${DEST_PATH}/chaindata"
sudo rm -rf "${DEST_PATH}/lightchaindata"

# Copy chaindata folders
sudo cp -r "${MOUNTPOINT}/geth/chaindata" ${DEST_PATH}
sudo cp -r "${MOUNTPOINT}/geth/lightchaindata" ${DEST_PATH}

echo "Finished backing up volume: ${VOLUME_NAME}"

# Deployer

This repo contains all the necessary config and scripts to run [go-geth](https://github.com/gojoychain/go-geth) nodes.

## Minimum Requirements

1. Linux-based AMD64 arch type OS
2. Dual-core CPU
3. 2 GB RAM
4. Rsyslog installed

## New Node Setup

Please note this setup is meant for deployment on AWS EC2 Linux instances where the default user is `ubuntu`, but can be adjusted to your environment. **If your default user is not `ubuntu`, see [changing data dir](#changing-data-dir) for instructions.**

1. Clone repo
2. Create the `.gojoy` data directory in your home directory: `~/.gojoy`
3. [Create env file](#environment-setup)
4. Create the `PW_FILE` if you are attaching an account to the node
5. Create the `PK_FILE` if you are attaching an account to the node
6. Create the `BOOTNODE_KEY` if you are running a bootnode
7. [Setup log rotations](#setup-automatic-log-rotation)
8. `cd deployer/scripts`
9. Download the required binaries by running `./download-bin.sh`
10. Run init script and pass in your newly-created .env file: `./init.sh ~/.gojoy/mainnet/.env`
11. Use the [system command](#start-service) to start the bootnode
12. Use the [system command](#start-service) to start the node

**Note: all system services automatically auto-run on reboots.**

## Changing Data Dir

If your default user is not `ubuntu` you will need to change the following. The default `DATA_DIR_ROOT` is set to `/home/ubuntu/.gojoy`. You can change replace `ubuntu` with whatever your default user is: `/home/myuser/.gojoy`.

1. `WorkingDirectory`, `EnvironmentFile`, and `ExecStart` fields in each `services/*.service` file
2. `DATA_DIR` in your .env file
3. `BOOTNODE_KEY` in your .env file (if running a bootnode)
4. `PW_FILE` in your .env file (if attaching an account)
5. `PK_FILE` in your .env file (if attaching an account)

## Environment Setup

- [Chain ID](https://docs.gojoychain.com/docs/deploy-node-metadata/#chain-id)
- [Bootnodes](https://docs.gojoychain.com/docs/deploy-node-metadata/#bootnodes)
- Default mainnet .env location: `~/.gojoy/mainnet/.env`
- Default testnet .env location: `~/.gojoy/testnet/.env`

### Client Env

See `example-client.env` for an example. You will need to create this `.env` file in the `DATA_DIR` location. Below is the explanation for each field.

```bash
# Network type: mainnet|testnet
NETWORK=mainnet

# Node type: client|sealer
NODE_TYPE=client

# Chain ID for the chain
CHAIN_ID=18

# Data directory where all geth data will go
DATA_DIR=/home/ubuntu/.gojoy/mainnet

# Port where the node will listen for other nodes trying to connect
LISTEN_PORT=30303

# Port for HTTP-RPC server
RPC_PORT=8545

# Port for WS-RPC server
WS_PORT=8546

# Comma-separated values for all the bootnodes
BOOTNODES=enode://daacb9a4f063b06ee1b8524082004b6cd54f21aa56e0bad0e1610a10dc28ec0a95a7a4b75db40f8882cd0afbaac2288220215d85e54924527189d0842945dce2@52.199.152.20:30301,enode://19ddf4a078494c7b36ec4f416992928d34d523f8c636069fc8f1b8e0be97dc446229932cb50b9089c2ac6566b6c827cd3ef6ec3cc363210278333f61cbc66743@52.52.158.2:30301,enode://3b9a82d404e29a47dfb3266548921719522ec5d16c33ce84edca808c53a7bfff035cd0901c90552620d7a0213ec4651b08190f0ab7806a0c69164d0abf95ffe8@52.47.183.206:30301

# Bootnode key if you are running a bootnode on this server (optional)
BOOTNODE_KEY=/home/ubuntu/.gojoy/mainnet/boot.key

# Bootnode port where it will listen for incoming connections (optional)
BOOTNODE_PORT=30301
```

### Sealer Env

See `example-sealer.env` for an example. You will need to create this `.env` file in the `DATA_DIR` location. Below is the explanation for each field.

```bash
# Network type: mainnet|testnet
NETWORK=mainnet

# Node type: client|sealer
NODE_TYPE=client

# Chain ID for the chain
CHAIN_ID=18

# Data directory where all geth data will go
DATA_DIR=/home/ubuntu/.gojoy/mainnet

# Account which will be imported into the sealer. This will serve as the etherbase account.
ACCOUNT_ADDRESS=0x0000000000000000000000000000000000000000

# Password file for the account. Plain text file with the account's password.
PW_FILE=/home/ubuntu/.gojoy/mainnet/.accountpw

# Private key file for the account. Plain text file with the account's private key.
PK_FILE=/home/ubuntu/.gojoy/mainnet/.accountpk

# Port where the node will listen for other nodes trying to connect
LISTEN_PORT=30303

# Comma-separated values for all the bootnodes
BOOTNODES=enode://daacb9a4f063b06ee1b8524082004b6cd54f21aa56e0bad0e1610a10dc28ec0a95a7a4b75db40f8882cd0afbaac2288220215d85e54924527189d0842945dce2@52.199.152.20:30301,enode://19ddf4a078494c7b36ec4f416992928d34d523f8c636069fc8f1b8e0be97dc446229932cb50b9089c2ac6566b6c827cd3ef6ec3cc363210278333f61cbc66743@52.52.158.2:30301,enode://3b9a82d404e29a47dfb3266548921719522ec5d16c33ce84edca808c53a7bfff035cd0901c90552620d7a0213ec4651b08190f0ab7806a0c69164d0abf95ffe8@52.47.183.206:30301

# Bootnode key if you are running a bootnode on this server (optional)
BOOTNODE_KEY=/home/ubuntu/.gojoy/mainnet/boot.key

# Bootnode port where it will listen for incoming connections (optional)
BOOTNODE_PORT=30301
```

## Logging

The different log files are located at:

```text
/var/log/geth/mainnet/geth.log
/var/log/geth/testnet/geth.log
/var/log/geth/mainnet/bootnode.log
/var/log/geth/testnet/bootnode.log
```

### Setup Automatic Log Rotation

For adding automatic log rotations, create a new config file at `/etc/logrotate.d` and add the following.

```bash
$ sudo vim /etc/logrotate.d/gojoy

# Paste the config below and save the file
/var/log/geth/mainnet/geth.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
/var/log/geth/mainnet/bootnode.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
/var/log/geth/testnet/geth.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
/var/log/geth/testnet/bootnode.log {
    missingok
    daily
    create 0644 syslog adm
    size 100M
    copytruncate
    maxage 14
    rotate 9
}
```

## Services

After running the `init.sh` script, you will now have systemd service(s) added. These are the following services depending on your env config:

```bash
geth_client_mainnet
geth_client_testnet
geth_sealer_mainnet
geth_sealer_testnet
bootnode_mainnet
bootnode_testnet
```

### Start Service

```bash
$ sudo systemctl start $SERVICE_NAME
```

### Stop Service

```bash
$ sudo systemctl stop $SERVICE_NAME
```

### Check Status

```bash
$ systemctl status $SERVICE_NAME
```

## Attach Geth Console

```bash
$ cd scripts
$ ./attach.sh
```

## Updating static-nodes.json

```bash
$ cd scripts
$ ./update-static-nodes.sh
```

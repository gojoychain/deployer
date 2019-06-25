# Deployer

This repo contains all the necessary Docker config and scripts to run [go-geth](https://github.com/gojoychain/go-geth) nodes.

Refer to our [docs](https://docs.gojoychain.com) for usage instructions.

## Linux AMD64 OS

### Minimum Requirements

1. Linux-based AMD64 arch type OS
2. Dual-core CPU
3. 2 GB RAM

### New Node Setup

1. Clone repo
2. `cd deployer/script`
3. Download the required binaries: `./download-bin.sh`
4. `cd ../[mainnet/testnet]/[sealer/client]`
5. Create env file: `vim .env`. See [Chain ID](https://docs.gojoychain.com/docs/deploy-node-metadata/#chain-id) and [Bootnodes](https://docs.gojoychain.com/docs/deploy-node-metadata/#bootnodes) for the values.

        # Example .env for mainnet client
        CHAIN_ID=18
        BOOTNODES=enode://daacb9a4f063b06ee1b8524082004b6cd54f21aa56e0bad0e1610a10dc28ec0a95a7a4b75db40f8882cd0afbaac2288220215d85e54924527189d0842945dce2@52.199.152.20:30301,enode://19ddf4a078494c7b36ec4f416992928d34d523f8c636069fc8f1b8e0be97dc446229932cb50b9089c2ac6566b6c827cd3ef6ec3cc363210278333f61cbc66743@52.52.158.2:30301,enode://3b9a82d404e29a47dfb3266548921719522ec5d16c33ce84edca808c53a7bfff035cd0901c90552620d7a0213ec4651b08190f0ab7806a0c69164d0abf95ffe8@52.47.183.206:30301
        LOG_DIR=/var/log/geth
        DATA_DIR=/home/ubuntu/.joy/mainnet
        SERVICE_FILE=/home/ubuntu/deployer/mainnet/client/geth.service
        SYSLOG_CONF_FILE=/home/ubuntu/deployer/script/geth.conf
        GENESIS_FILE=/home/ubuntu/deployer/mainnet/genesis.json
        STATIC_NODE_FILE=/home/ubuntu/deployer/mainnet/static-nodes.json

6. Run init script: `./init.sh`. This creates a Linux system service for geth among other necessary setup.
7. `cd ../../script`
8. `./start.sh` to start the node
9. Note that the geth system service is now setup to auto-run on reboots.

### Start Node

```bash
/script/start.sh
```

### Stop Node

```bash
/script/stop.sh
```

### Check Node Status

```bash
systemctl status geth
```

### Attach Geth Console

```bash
/script/attach.sh [mainnet/testnet]
```

### Logging

Logs are stored and rotated in `/var/log/geth/geth.log`.

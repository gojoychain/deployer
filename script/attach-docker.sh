#!/bin/sh

docker exec -it $1 /usr/local/bin/geth attach ipc:/root/.ghu/geth.ipc

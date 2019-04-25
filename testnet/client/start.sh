#!/bin/sh
export $(cat .env | xargs) && ../../node-sealer/start-client-nohup.sh

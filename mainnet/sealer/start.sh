#!/bin/sh

export $(cat .env | xargs) && ../../sealer/start-node-nohup.sh

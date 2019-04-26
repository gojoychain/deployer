FROM ghuchain/ghu-geth:v1.8.23a

# Copy genesis.json
ARG GENESIS_PATH
COPY ${GENESIS_PATH} /root/.ghu/

# Run init genesis script
COPY ./script/init-genesis.sh /usr/local/bin
RUN init-genesis.sh

# Import account
ARG PRIVATE_KEY
ARG PASSWORD
RUN echo $PRIVATE_KEY > /root/.ghu/.privatekey
RUN echo $PASSWORD > /root/.ghu/.accountpw
RUN geth --datadir /root/.ghu account import --password /root/.ghu/.accountpw /root/.ghu/.privatekey

# Create env vars for shell script
ARG BOOTNODES
ARG CHAIN_ID
ARG ADDRESS
ARG ETHERBASE_ADDRESS
ENV BOOTNODES=$BOOTNODES
ENV CHAIN_ID=$CHAIN_ID
ENV ETHERBASE_ADDRESS=$ETHERBASE_ADDRESS
ENV ADDRESS=$ADDRESS

# Run start script
COPY ./node-sealer/start-node-docker.sh /usr/local/bin
ENTRYPOINT ["start-node-docker.sh"]

# Expose ports
ARG EXPOSED_PORTS
EXPOSE ${EXPOSED_PORTS}

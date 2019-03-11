FROM ghuchain/ghu-bootnode:v1.8.23a

# Copy bootkey
RUN mkdir /root/.ghu
ARG BOOTKEY_PATH
COPY ${BOOTKEY_PATH} /root/.ghu/boot.key

# Start bootnode
CMD ["-nodekey", "/root/.ghu/boot.key", "-verbosity", "9"]

# Expose ports
EXPOSE 30301

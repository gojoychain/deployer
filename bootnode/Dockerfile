FROM ghuchain/ghu-bootnode:v1.8.23a

# Copy bootkey
RUN mkdir /root/.joy
ARG BOOTKEY_PATH
COPY ${BOOTKEY_PATH} /root/.joy/boot.key

# Start bootnode
CMD ["-nodekey", "/root/.joy/boot.key", "-verbosity", "9"]

# Expose ports
EXPOSE 30301

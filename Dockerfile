FROM rust:1-slim-buster AS builder
ARG NYM_VERSION=v0.9.2
WORKDIR /app
RUN set -ex
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev pkg-config git tini
RUN git clone https://github.com/nymtech/nym.git
RUN cd ./nym && git checkout tags/${NYM_VERSION} && cd ./mixnode && cargo build --release

FROM bitnami/minideb:buster
RUN set -ex && install_packages libssl1.1 ca-certificates
VOLUME [ "/root/.nym" ]
ENTRYPOINT ["/tini", "-v", "--"]
CMD [ "/usr/local/bin/nym-mixnode", "run", "--id", "mixer"]
COPY --from=builder /app/nym/target/release/nym-mixnode /usr/local/bin/
COPY --from=builder /usr/bin/tini-static /tini
COPY init.sh init.sh
COPY config.toml /root/.nym/mixnodes/config/config.toml
RUN ./init.sh

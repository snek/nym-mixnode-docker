FROM rust:1-slim-buster AS builder
WORKDIR /app
ARG NYM_VERSION
RUN set -ex
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev pkg-config git
RUN git clone https://github.com/nymtech/nym.git
RUN cd ./nym && git checkout tags/${NYM_VERSION} && cd ./mixnode && cargo build --release

FROM bitnami/minideb:buster
VOLUME [ "/root/.nym" ]
RUN set -ex && install_packages libssl1.1 ca-certificates
COPY --from=builder /app/nym/target/release/nym-mixnode /usr/local/bin/

CMD ["nym-mixnode", "run", "--id=mixer"]

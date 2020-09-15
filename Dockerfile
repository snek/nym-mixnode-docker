FROM rust:1-slim-buster AS builder
ARG NYM_VERSION=v0.8.0
WORKDIR /app
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev pkg-config git \
    && git clone https://github.com/nymtech/nym.git \
    && cd ./nym \
    && git checkout tags/${NYM_VERSION} \
    && cd ./mixnode \
    && cargo build --release

FROM gcr.io/distroless/cc
# ARG TINI_VERSION=v0.19.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
# ENTRYPOINT ["/sbin/tini", "-v", "--"]
# CMD [ "nym-mixnode" ]
ENTRYPOINT [ "/usr/local/bin/nym-mixnode" ]
COPY --from=builder /app/nym/target/release/nym-mixnode /usr/local/bin/
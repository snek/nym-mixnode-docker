FROM rust:1-slim-buster AS builder
ARG NYM_VERSION=v0.8.0
WORKDIR /app
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev pkg-config git tini \
    && git clone https://github.com/nymtech/nym.git \
    && cd ./nym \
    && git checkout tags/${NYM_VERSION} \
    && cd ./mixnode \
    && cargo build --release

FROM gcr.io/distroless/cc
ENTRYPOINT ["/tini", "-v", "--"]
CMD [ "/usr/local/bin/nym-mixnode" ]
COPY --from=builder /app/nym/target/release/nym-mixnode /usr/local/bin/
COPY --from=builder /usr/bin/tini-static /tini
# nym-mixnode-docker

This is a multistage Docker image of the nym mixnode. The official nym repository can be found here:
https://github.com/nymtech/nym

## Setup

### Configuration

```sh
# copy the config file and adjust where needed
cp config.toml.example config.toml
```

### Building

```sh
# build the nym-mixnode docker image
docker-compose build
```

### Certificates


```sh
# generate certificates in case you don't have them yet
docker run --rm \
  -v ${PWD}/data:/root/.nym/mixnodes/mixer/data \
  nym-mixnode \
  nym-mixnode init --id=mixer --host=0.0.0.0
```

**Note:**
1. if you already have the certificates just place them into `./data`
2. if you do need to generate the certificates you will need to build the docker image first

## Running

```sh
# start your node
docker-compose up -d
```

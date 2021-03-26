# nym-mixnode-docker

This is a multistage Docker image of the nym mixnode. The official nym repository can be found here:
https://github.com/nymtech/nym

## Usage

### Configuration

```sh
# copy the config file and adjust where needed
cp config.toml.example config.toml
```

### Running

```sh
# start your node with the following command
docker-compose up

# to run in the background, use the --detach flag
docker-compose up -d
```

**Note:** when running the container for the first time it will compile the image from source as we're not using a registry. It will also generate the certificates if needed, on a Raspberry Pi 4 Model B this takes ~ 15 minutes.

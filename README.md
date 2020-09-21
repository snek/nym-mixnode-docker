# nym-mixnode-docker
This is a multistage Docker image of the nym mixnode. 
The official nym repository can be found here:
https://github.com/nymtech/nym

The image uses https://github.com/krallin/tini to handle the init. Considering it's not possible to do a `docker run --init` in Kubernetes it was added directly to the image.

The first stage of the build generates the executable and installs `tini` using `apt`. In the second stage these 2 files are copied out into a ~~https://github.com/GoogleContainerTools/distroless container, resulting in the smallest possible Docker image of only 11MB.~~

For the sake of usability and being able to run bash scripts in the container I have decided to not use distroless and go with https://hub.docker.com/r/bitnami/minideb instead. This more than doubles the size of the image but it's still below 90MB.


## Usage

### Registry
The docker image is automatically built and can be pulled from Docker hub:
https://hub.docker.com/r/snekone/nym-mixnode-docker


### Configuration
The nym mixnode assumes there's a config.toml and two pem files. The location of the pem files can be configured in the config.toml. There's an example toml file which has all the possible options.

The CMD is setup to be:
`CMD [ "/usr/local/bin/nym-mixnode", "run", "--id", "mixer"]`

This means the process will assume the name of the node is "mixer" and will look in the following directory for the config file:
`/root/.nym/mixnodes/mixer/config/config.toml`

A VOLUME is configured for the directory:
`VOLUME [ "/root/.nym" ]`
This lets you mount this directory for easy configuration.
`docker run -v $PWD/config:/root/.nym snekone/nym-mixnode-docker`
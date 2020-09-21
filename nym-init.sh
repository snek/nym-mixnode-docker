#!/usr/bin/env bash
while getopts h:i:l: option
do
    case "${option}"
        in
        h) HOST=${OPTARG};;
        i) ID=${OPTARG};;
        l) LAYER=${OPTARG};;
    esac
done

echo "Checking for pem files"
if [ ! -f /root/.nym/mixnode/mixer/data/private_sphinx.pem ] || [ ! -f /root/.nym/mixnode/mixer/data/public_sphinx.pem ]; then
    echo "Missing pem files, running init"
    nym-mixnode init --host ${HOST} --id ${ID} --layer ${LAYER}
fi
if [ -f /root/.nym/mixnode/mixer/data/private_sphinx.pem ] && [ -f /root/.nym/mixnode/mixer/data/public_sphinx.pem ]; then
    echo "Pem files found"
fi

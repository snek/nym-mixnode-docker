#!/usr/bin/env bash

echo "Checking for pem files"
if [ ! -f /root/.nym/mixnode/mixer/data/private_sphinx.pem ] || [ ! -f /root/.nym/mixnode/mixer/data/public_sphinx.pem ]; then
    echo "Missing pem files, running init"
    nym-mixnode init --id mixer --host=0.0.0.0
fi
if [ -f /root/.nym/mixnode/mixer/data/private_sphinx.pem ] && [ -f /root/.nym/mixnode/mixer/data/public_sphinx.pem ]; then
    echo "Pem files found"
fi

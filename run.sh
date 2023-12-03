#!/bin/sh

docker build -t openipc-dev .

[ ! -d firmware ] &&
  git clone https://github.com/OpenIPC/firmware.git

docker run --rm -it \
    --mount type=bind,source="$(pwd)/firmware",target=/home/openipc/firmware \
    openipc-dev:latest

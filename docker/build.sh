#!/usr/bin/env bash
set -o errexit

# travel to the location of the build script
cd $(dirname ${BASH_SOURCE[0]})

docker build \
    --network host \
    --tag fpga-bitter \
    .

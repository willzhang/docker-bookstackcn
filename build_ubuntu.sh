#!/bin/bash
BOOKSTACK_VERSION=v2.9
docker build -t willdockerhub/bookstack:ubuntu_${BOOKSTACK_VERSION} -f Dockerfile.ubuntu .

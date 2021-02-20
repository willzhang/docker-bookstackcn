#!/bin/bash
BOOKSTACK_VERSION=v2.9
docker build -t willdockerhub/bookstack:${BOOKSTACK_VERSION}_node -f Dockerfile.node .

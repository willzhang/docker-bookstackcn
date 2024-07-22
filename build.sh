#!/bin/bash
BOOKSTACK_VERSION=v2.12
docker build -t docker.io/willdockerhub/bookstack:${BOOKSTACK_VERSION} -f Dockerfile .

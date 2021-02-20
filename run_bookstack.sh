#!/bin/bash
docker run -d --name bookstack \
  --restart always \
  -p 8181:8181 \
  -v /data/bookstack/conf:/bookstack/conf \
  willdockerhub/bookstack:v2.9_node

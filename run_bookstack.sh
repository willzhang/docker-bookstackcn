#!/bin/bash
#docker rm -f bookstack
docker run -itd --name bookstack \
  --restart always \
  -p 8181:8181 \
  -v /data/bookstack/conf:/opt/bookstack/conf \
  willdockerhub/bookstack

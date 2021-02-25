#!/bin/sh
# generate config
python3 /tmp/conf/generate.py app.conf.jinja app.conf
python3 /tmp/conf/generate.py oauth.conf.jinja oauth.conf
python3 /tmp/conf/generate.py oss.conf.jinja oss.conf

# run bookstack
/bookstack/BookStack install && /bookstack/BookStack

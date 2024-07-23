#!/bin/bash

# generate conf
config_files=(app.conf oauth.conf oss.conf)
for file in ${config_files[*]}
do
  if [ ! -f "/bookstack/conf/$file" ]; then
    envsubst < /tmp/conf/${file}.example > /bookstack/conf/${file}
  fi
done

/bookstack/BookStack install

exec "$@"

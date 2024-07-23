#!/bin/bash
set -e

log() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') $1"
}

BASE_PATH=/www/wwwroot

# Generate configuration files if they do not exist
config_files=(app.conf oauth.conf oss.conf)
mkdir -p ${BASE_PATH}/conf

log "Checking and generating configuration files..."
for file in "${config_files[@]}"
do
  if [ ! -f "${BASE_PATH}/conf/$file" ]; then
    log "Generating configuration file: $file"
    envsubst < /tmp/conf/${file}.example > ${BASE_PATH}/conf/${file}
    log "Configuration file generated: ${BASE_PATH}/conf/$file"
  else
    log "Configuration file already exists: ${BASE_PATH}/conf/$file"
  fi
done

# Install BookStack if not already installed
if [ ! -f "${BASE_PATH}/.installed" ]; then
    log "BookStack not installed. Starting installation..."
    ${BASE_PATH}/BookStack install
    touch ${BASE_PATH}/.installed
    log "BookStack installation completed. Created .installed file."
else
    log "BookStack already installed. Skipping installation."
fi

# Start BookStack
log "Starting BookStack..."
exec ${BASE_PATH}/BookStack

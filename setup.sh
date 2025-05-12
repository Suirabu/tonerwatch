#!/usr/bin/env bash

# create directory for tonerwatch files
mkdir -p tonerwatch
cd tonerwatch

# download necessary files
curl -sO https://raw.githubusercontent.com/Suirabu/tonerwatch/refs/heads/main/monitor.sh
curl -sO https://raw.githubusercontent.com/Suirabu/tonerwatch/refs/heads/main/README.md

# set up configuration files
echo "PRINTER NAME,PRINTER LOCATION,IP ADDRESS,COLOR" > printers.csv
echo "printers.csv" > .gitignore

# make monitor script executable
chmod +x monitor.sh

echo "TonerWatch setup complete in $(pwd)"
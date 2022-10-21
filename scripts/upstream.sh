#!/bin/sh

LINK=https://raw.githubusercontent.com/miladrahimi/v2ray-docker-compose/master
NAME=v2ray-upstream-server

mkdir -p $NAME/config && cd $NAME || exit
curl -s "$LINK/$NAME/docker-compose.yml" --output docker-compose.yml
curl -s "$LINK/$NAME/config/config.json" --output config/config.json

printf "%s" "Enter UPSTREAM-UUID (Leave empty to generate a random one): "
read -r UPSTREAM_UUID
if [ -z "$UPSTREAM_UUID" ]; then UPSTREAM_UUID=$(cat /proc/sys/kernel/random/uuid); fi

sed -ie "s/<UPSTREAM-UUID>/$UPSTREAM_UUID/g" config/config.json

printf "The Docker-compose and configuration files are ready."

printf "UPSTREAM-IP: %s" "$(curl -s ifconfig.io)"
printf "UPSTREAM-UUID: %s" "$UPSTREAM_UUID"

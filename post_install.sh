#!/usr/bin/env bash

version="$(cat /root/.PLUGIN_VERSION)"
sysrc plugin_initialized="${version}"
sysrc plugin_version="${version}"

## Configure the jail's primary service using rcvars
sysrc zwavejs2mqtt_app_dir=/usr/local/share/zwavejs2mqtt
sysrc zwavejs2mqtt_store_dir=/usr/local/etc/zwavejs2mqtt

## Install the jail's primary service, zwavejs2mqtt
/root/bin/install_zj2m

## Enable and start the service
sysrc zwavejs2mqtt_enable="YES"
service zwavejs2mqtt start

## Start the console menu, upon login as user "root"
echo -e "\n# Start console menu after login." >> /root/.login
echo "if ( -x /root/bin/menu ) menu" >> /root/.login

## Gererate PLUGIN_INFO
/root/bin/plugin_info

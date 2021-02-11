#!/usr/bin/env bash

plugin_version="1.0.20210211"
sysrc plugin_initialized="1.0.$(date +%Y%m%d)"
sysrc plugin_version="${plugin_version}"

## Configure the jail's primary service using rcvars
sysrc zwavejs2mqtt_app_dir=/usr/local/share/zwavejs2mqtt
sysrc zwavejs2mqtt_store_dir=/usr/local/etc/zwavejs2mqtt

## Install the jail's primary service, zwavejs2mqtt
/root/bin/z2m-install

## Enable and start the service
sysrc zwavejs2mqtt_enable="YES"
service zwavejs2mqtt start

## Start the console menu, upon login as user "root"
echo -e "\n# Start console menu after login." >> /root/.login
echo "if ( -x /root/bin/menu ) menu" >> /root/.login

#!/usr/bin/env bash

sysrc zwavejs2mqtt_app_dir=/usr/local/share/zwavejs2mqtt
sysrc zwavejs2mqtt_store_dir=/usr/local/etc/zwavejs2mqtt

/root/bin/z2m-install

sysrc zwavejs2mqtt_enable="YES"
service zwavejs2mqtt start

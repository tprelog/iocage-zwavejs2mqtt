#!/bin/sh

sysrc zwavejs2mqtt_app_dir=/usr/local/share/zwavejs2mqtt
sysrc zwavejs2mqtt_store_dir=/usr/local/etc/zwavejs2mqtt

/root/bin/z2m_install

sysrc zwavejs2mqtt_enable="YES"
service zwavejs2mqtt start

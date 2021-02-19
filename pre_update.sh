#!/usr/bin/env bash

# shellcheck disable=SC1091
. /etc/rc.subr && load_rc_config
: "${plugin_upgrade_service:="NO"}"

# shellcheck disable=SC2154
if [ "${plugin_version%%.*}" == "1" ]; then
  true
else # this is a place holder for future use
  warn "unknown version"
fi

upgrade_service() {
  ## If enabled, upgrade zwavejs2mqtt during a Plugin UPDATE
  ## Use `sysrc plugin_upgrade_service=YES` to enable
  service zwavejs2mqtt stop 2>/dev/null
  sysrc -x zwavejs2mqtt_enable 2>/dev/null
}

checkyesno plugin_upgrade_service && upgrade_service

## Exit 0, else a Plugin UPDATE will fail here
exit 0

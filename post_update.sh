#!/usr/bin/env bash

# shellcheck disable=SC1091
. /etc/rc.subr && load_rc_config
: "${plugin_enable_pkglist:="NO"}"
: "${plugin_upgrade_service:="YES"}"

install_pkglist() {
  ## If enabled, re-install packages from a pkglist, after a Plugin UPDATE
  ## Use `sysrc plugin_pkglist="/path/to/pkglist"` to set a pkglist
  ## Use `sysrc plugin_enable_pkglist=YES` to enable
  local pkgs ; pkgs=$(cat "${plugin_pkglist:-/dev/null}")
  echo -e "\nChecking for additional packages to install..."
  echo "${pkgs}" | xargs pkg install -y
}

upgrade_service() {
  ## Enabled by default, upgrade zwavejs2mqtt during a Plugin UPDATE
  ## Use `sysrc plugin_upgrade_service=NO` to disable
  /root/bin/install_zj2m
}

checkyesno plugin_enable_pkglist && install_pkglist
checkyesno plugin_upgrade_service && upgrade_service

sysrc plugin_version="$(cat /root/.PLUGIN_VERSION)"

## Gererate PLUGIN_INFO
/root/bin/plugin_info

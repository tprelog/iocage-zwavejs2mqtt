#!/usr/bin/env bash

# shellcheck disable=SC1091
. /etc/rc.subr && load_rc_config
: "${plugin_enable_pkglist:="NO"}"
: "${plugin_upgrade_service:="NO"}"

install_pkglist() {
  ## If enabled, re-install packages from a pkglist, after a Plugin UPDATE
  ## Use `sysrc plugin_pkglist="/path/to/pkglist"` to set a pkglist
  ## Use `sysrc plugin_enable_pkglist=YES` to enable
  local pkgs ; pkgs=$(cat "${plugin_pkglist:-/dev/null}")
  echo -e "\nChecking for additional packages to install..."
  echo "${pkgs}" | xargs pkg install -y
}

upgrade_service() {
  ## If enabled, upgrade zwavejs2mqtt during a Plugin UPDATE
  ## Use `sysrc plugin_upgrade_service=YES` to enable
  /root/bin/z2m-install \
  && sysrc zwavejs2mqtt_enable="YES" \
  && service zwavejs2mqtt start
}

checkyesno plugin_enable_pkglist && install_pkglist
checkyesno plugin_upgrade_service && upgrade_service

echo "TODO: Update the PLUGIN_INFO"

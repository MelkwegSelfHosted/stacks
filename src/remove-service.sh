#!/bin/bash

#
#RUN AS SUDO
#

SERVICE_NAME=$1

echo $SERVICE_NAME


systemctl stop $SERVICE_NAME
systemctl disable $SERVICE_NAME
rm /etc/systemd/system/$SERVICE_NAME
rm /etc/systemd/system/$SERVICE_NAME # and symlinks that might be related
rm /usr/lib/systemd/system/$SERVICE_NAME
rm /usr/lib/systemd/system/$SERVICE_NAME # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed

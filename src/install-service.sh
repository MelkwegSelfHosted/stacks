#!/bin/bash
#

export SERVICE=$1


# Argument validation check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

if [ ! -d "./$SERVICE" ]; then
  echo "$SERVICE folder does not exist. Exiting."
  exit 2
fi

# Sanity check
if [ "$EUID" -ne 0 ]
  then echo "Please run as root. Exiting"
  exit 3
fi

if [ ! -f "./SERVICE.service.template" ]; then
    echo "Template file could not be found. Exiting."
    exit 4
fi

if [ -f "./$SERVICE/$SERVICE.service" ]; then
    echo -e "./$SERVICE/$SERVICE.service file already exists.\nDo you want to overwrite it (y/n)? "
    read answer

    if [ "$answer" != "${answer#[Nn]}" ] ;then
      echo "Exiting."
      exit 5
    fi
fi


if [ -f "/etc/systemd/system/$SERVICE.service" ]; then
     echo -e "$SERVICE already installed at /etc/systemd/system.\nDo you want to overwrite it (y/n)? "
     read answer

     if [ "$answer" != "${answer#[Nn]}" ] ;then
        echo "Exiting."
        exit 6
      else
        systemctl stop $SERVICE
        systemctl disable $SERVICE
        rm /etc/systemd/system/$SERVICE.service
     fi
 fi


echo "Installing service $SERVICE."

echo "Generating service file..."
STACKS_FOLDER=${PWD} \
  envsubst <./SERVICE.service.template >./$SERVICE/$SERVICE.service

echo "Setting the correct permissions..."
chmod a+rx ./$SERVICE/$SERVICE.service

echo "Moving file to systemd folder..."
ln -s $(realpath ./$SERVICE/$SERVICE.service) /etc/systemd/system/$SERVICE.service

echo "Enabling service..."
systemctl enable $SERVICE.service


echo -e "Do you want to start the service (y/n)? "
read answer

if [ "$answer" != "${answer#[Nn]}" ] ;then
  echo "Type 'sudo systemctl start $SERVICE' to start the service."
else
  systemctl start $SERVICE
fi

echo "Done."

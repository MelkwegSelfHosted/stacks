#!/bin/bash
#

export SERVICE=$1


# Argument validation check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <service-name>"
    exit 1
fi

echo "Installing service $SERVICE."

STACKS_FOLDER=${PWD} \
  envsubst <./SERVICE.service.template >./$SERVICE/$SERVICE.service

echo "Done."

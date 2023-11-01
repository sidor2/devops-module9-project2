#!/usr/bin/env bash

export IMAGE=$1
echo "DEBUG: IMAGE is set to $IMAGE"
docker-compose -f docker-compose.yaml up --detach
echo "success"
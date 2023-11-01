#!/usr/bin/env bash

export IMAGE=$1
echo "DEBUG: IMAGE is set to $IMAGE"
echo "IMAGE=$IMAGE" >> image.env
docker-compose -f docker-compose.yaml up --detach
echo "success"
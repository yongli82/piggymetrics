#!/usr/bin/env bash

export CONFIG_SERVICE_PASSWORD=password
export NOTIFICATION_SERVICE_PASSWORD=password
export STATISTICS_SERVICE_PASSWORD=password
export ACCOUNT_SERVICE_PASSWORD=password
export MONGODB_PASSWORD=password

docker-compose -f docker-compose.yml -f docker-compose.dev.yml build
#docker-compose -f docker-compose.yml -f docker-compose.dev.yml up

docker-compose -f docker-compose.yml push

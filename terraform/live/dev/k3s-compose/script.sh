#!/bin/bash
set -exu

docker-compose -p k0s -f ../../../modules/k3s-compose/latest/docker-compose.yml up -d
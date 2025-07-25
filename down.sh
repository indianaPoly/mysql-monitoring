#!/bin/bash

# step 1 : monitoring stop
echo "[INFO] Stopping Monitoring >>> Prometheus and Grafana"
docker-compose -f ./monitoring/docker-compose.yml --env-file ./monitoring/.env down

# step 2 : db stop
echo "[INFO] Stopping DB >>> mysql"
docker-compose -f ./DB/mysql/docker-compose.yml --env-file ./DB/mysql/.env down

# step 3 : remove docker network if exists
if docker network ls | grep -q monitor_net; then
    echo "[INFO] Removing docker network >>> monitor_net"
    docker network rm monitor_net
fi

echo "[SUCCESS] All Services stopped and network removed!"

# step 1 : docker network
if ! docker network ls | grep -q monitor_net; then
    echo "[INFO] Creating docker network >>> monitor_net"
    docker network create monitor_net
fi

# step 2 : db start
echo "[INFO] Starting DB >>> mysql"
docker-compose -f ./DB/mysql/docker-compose.yml --env-file ./DB/mysql/.env up -d

# step 3 : monitoring start
echo "[INFO] Starting Monitoring >>> Prometheus and Grafana"
docker-compose -f ./monitoring/docker-compose.yml --env-file ./monitoring/.env up -d

echo "[SUCCESS] All Services started!"
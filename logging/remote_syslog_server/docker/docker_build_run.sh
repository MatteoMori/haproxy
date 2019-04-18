#! /bin/bash


#----------------------------------------------------
# Create Docker network bridge
#----------------------------------------------------
docker network create -d bridge haproxy_network_test

#----------------------------------------------------
# Stop running containers
#----------------------------------------------------
docker stop syslog_server && docker rm syslog_server
docker stop web_server && docker rm web_server
docker stop haproxy && docker rm haproxy

#----------------------------------------------------
# Build Containers 
#----------------------------------------------------
docker build -t syslog_server -f Dockerfile.syslog_server .
docker build -t web_server -f Dockerfile.web_server .
docker build -t haproxy -f Dockerfile.haproxy .



#----------------------------------------------------
# Run containers on the same docker network 
#----------------------------------------------------
#docker run -d --name syslog_server -p 514:514/udp --net haproxy_network_test syslog_server
docker run -d --name syslog_server --net haproxy_network_test syslog_server
docker run -d --name web_server --net haproxy_network_test web_server
docker run -d -p 80:80 -p 9000:9000  --net haproxy_network_test --name haproxy haproxy

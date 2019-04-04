#! /bin/bash


#----------------------------------------------------
# Create Docker network bridge
#----------------------------------------------------
docker network create -d bridge haproxy_network_test

#----------------------------------------------------
# Stop running containers
#----------------------------------------------------
docker stop haproxy_matteo && docker rm haproxy_matteo
docker stop web1 && docker rm web1
docker stop web2 && docker rm web2
docker stop web1_tcp && docker rm web1_tcp
docker stop web2_tcp && docker rm web2_tcp

#----------------------------------------------------
# Build Containers 
#----------------------------------------------------
docker build -t haproxy_matteo -f Dockerfile.haproxy .
docker build -t web1 -f Dockerfile.nginx1 .
docker build -t web2 -f Dockerfile.nginx2 .
docker build -t web1_tcp -f Dockerfile.nginx1_tcp .
docker build -t web2_tcp -f Dockerfile.nginx2_tcp .

#----------------------------------------------------
# Run containers on the same docker network 
#----------------------------------------------------
docker run -d --name web1 --net haproxy_network_test web1
docker run -d --name web2 --net haproxy_network_test web2
docker run -d --name web1_tcp --net haproxy_network_test web1_tcp
docker run -d --name web2_tcp --net haproxy_network_test web2_tcp
docker run -d -p 80:80 -p 9000:9000 -p 81:81 --net haproxy_network_test --name haproxy_matteo haproxy_matteo

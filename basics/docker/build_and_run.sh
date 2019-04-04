#! /bin/bash
docker network create -d bridge haproxy_network_test

docker stop haproxy_matteo && docker rm haproxy_matteo
docker stop web1 && docker rm web1
docker stop web2 && docker rm web2

docker run -d --name web1 --net haproxy_network_test web1
docker run -d --name web2 --net haproxy_network_test web2

docker build -t haproxy_matteo -f Dockerfile.haproxy .

docker run -d -p 80:80  --net haproxy_network_test --name haproxy_matteo haproxy_matteo

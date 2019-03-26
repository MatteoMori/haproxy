# Basic test

## How to run it
1. `docker network create -d bridge my_network`
2. Build containers
```bash
docker build -t web1 -f Dockerfile.nginx1 .
docker build -t web2 -f Dockerfile.nginx2 .
docker build -t haproxy -f Dockerfile.haproxy .
```

3. Run containers on the same network. This is done so that HAProxy can resolve web1 and web2 addresses
```bash
docker run -d --name web1 --net my_network web1
docker run -d --name web2 --net my_network web2
docker run -d -p 80:80 --net my_network --name lb1 haproxy
```

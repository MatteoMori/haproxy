#! /bin/bash
docker stop haproxy_matteo && docker rm haproxy_matteo
docker build -t haproxy_matteo -f Dockefile.haproxy .
docker run -d -p 81:81 --name haproxy_matteo haproxy_matteo

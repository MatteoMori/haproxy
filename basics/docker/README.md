# Capture client's IP
## TCP
```bash
docker exec -ti web1_tcp bash

root@6f3209f4c275:/# cat /var/log/nginx/proxylog.log
172.19.0.1 - - [04/Apr/2019:18:12:55 +0000] "GET / HTTP/1.1" 200 165 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36"
```
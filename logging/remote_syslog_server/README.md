# # Logging to Remote syslog server

The purpose of this execise is to send HAProxy logs to a remote **syslog** server.
To do that we will set up:

1. One Syslog server
2. One HAProxy
3. One Nginx web server



## Syslog server setup

1. Enable UDP reception on port 514

   ```bash
   vim /etc/rsyslog.conf
   
        # Enable UDP syslog receiver
        module(load="imudp")
        input(type="imudp" port="514")
   ```

2. Configure logs so that:

   * If logs come from an application called `haproxy`, they will be stored in `/var/log/haproxy.log`.
   * If logs come from an application called `nginx_web1` , they will be stored in `/var/log/haproxy_nginx_web1.log`.

   ```bash
   vim /etc/rsyslog.d/haproxy.conf
   
         if $programname startswith 'haproxy' then /var/log/haproxy.log
         if $programname == 'nginx_web1' then /var/log/haproxy_nginx_web1.log
   ```

3. Restart `rsyslog`



## Set up HAProxy

1. Ensure to have the following options in your HAProxy config file (`/etc/haproxy/haproxy.cfg`)

```bash
#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    log 192.168.50.30:514 local0 info

defaults
    log         global
    option      dontlognull   # Skip logs if request does not send any data
    timeout connect 5s
    timeout client 120s
    timeout server 120s

#---------------------------------------------------------------------
# Frontend http_proxy -------- HTTP
#---------------------------------------------------------------------
frontend http_proxy
  mode http                  # Work as Layer 7 instaed of Layer 4
  bind *:80                  # passing * or null points to every IPs configured on the host
  option forwardfor if-none  # Capture client's IP address
  option httplog             # turn on verbose logging  --> Add to default if need to apply to all config
  default_backend http_servers
  log-tag nginx_web1         # Logs for this application will be segregated by HAProxy specific logs

#---------------------------------------------------------------------
# Backend http_servers -------- HTTP
#---------------------------------------------------------------------
backend http_servers
  mode http                  # Work as Layer 7 instaed of Layer 4
  balance roundrobin
  server web1 192.168.50.31:80
```



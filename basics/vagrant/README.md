# Vagrant approach

## Bring the machine up and SSH into it
```bash
vagrant up
vagrant ssh


# To stop the VM
vagrant halt

# to delete the vm
vagrant destroy
```

## Deploy HAProxy
[Docs](https://devops.ionos.com/tutorials/install-and-configure-haproxy-load-balancer-on-ubuntu-1604/)

```bash
  sudo apt-get update
  sudo apt-get -y install haproxy
  haproxy -v
  cat /etc/haproxy/haproxy.cfg
  service haproxy status
```

## Deploy Nginx
```bash
   sudo apt-get -y install nginx
```

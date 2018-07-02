#!/bin/bash
hosts=""

for i in $(seq 1 $1); do
  hosts+="        server web$i:80; \n"
done

cfg="
user nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    upstream localhost {
$hosts
    }

    server {
    listen 80;
    server_name localhost;
    location / {
       proxy_pass http://localhost;
       proxy_set_header Host \$host;
    }
  }

}"

echo -e "$cfg" > test_php/balancer/nginx.conf

#!/bin/bash
hosts=""
host=""

for i in $(seq 1 $1); do
  hosts+="
  web$i:
    depends_on:
      - db
    links:
      - db:db
    image: zlodey23/test_web
    restart: always
"
done

for i in $(seq 1 $1); do
  host+="        - web$i\n"
done

cfg="
version: '2'
services:
  db:
    build:
      context: base
      dockerfile: ./Dockerfile
    volumes:
    - ./base/data:/var/lib/mysql
    - ./base/config/utf8.cnf:/etc/mysql/conf.d/utf8.cnf
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_DATABASE: test_db
      MYSQL_USER: base_viewer
      MYSQL_PASSWORD: 123456
    ports:
      - "3306:3306"

  $hosts

  loadbalancer:
      image: nginx:stable
      volumes:
        - ./balancer/nginx.conf:/etc/nginx/nginx.conf
      links:
$host
      ports:
          - '80:80'
      environment:
      - NGINX_HOST=test-php.com
      - NGINX_PORT=80
      command: /bin/bash -c \"exec nginx -g 'daemon off;'\"
"

echo -e "$cfg" > test_php/docker-compose.yml

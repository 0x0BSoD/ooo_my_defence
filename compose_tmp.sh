hosts=""

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

cfg="
version: '3.3'
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
      build: ./balancer
      tty: true
      links:
          - web1
          - web2
      ports:
          - '80:80'
"

echo "$cfg" > docker-compose.yml

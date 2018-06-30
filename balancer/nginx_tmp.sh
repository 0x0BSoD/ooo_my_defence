hosts=""

for i in $(seq 1 $1); do
  num=$((10+$i))
  hosts+="\t\tserver 192.168.$num:3000;\n"
done

cfg=$(cat << EOF
http { \n
\tevents { worker_connections 1024; } \n
\tupstream localhost { \n
$hosts
\t} \n
\tserver { \n
\t\tlisten 8080; \n
\t\tserver_name localhost; \n
\t\tlocation / { \n
\t\t\tproxy_pass http://localhost; \n
\t\t\tproxy_set_header Host $host; \n
\t\t} \n
\t} \n
} \n
EOF
)

echo $cfg > balancer/nginx.conf

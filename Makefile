hello:
	@echo "Use make inst=NUM_OF_CLIENT_INSTANCES deploy"
deploy:
	@echo "Instances $(inst)"
	chmod +x balancer/nginx_tmp.sh
	balancer/nginx_tmp.sh $(inst)

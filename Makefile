hello:
		@echo "Use make inst=NUM_OF_CLIENT_INSTANCES deploy"

clean:
		vagrant destroy

init:
		vagrant up
		ansible-playbook -i hosts init.yml

deploy:
		@echo "Instances $(inst)"
		chmod +x nginx_tmp.sh
		chmod +x compose_tmp.sh
		./nginx_tmp.sh $(inst)
		./compose_tmp.sh $(inst)
		ansible-playbook -i hosts deploy.yml

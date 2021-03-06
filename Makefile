hello:
		@echo "make clean - destroy vagrant env"
		@echo "make init - init vagrant env"
		@echo "make inst=NUM_OF_CLIENT_INSTANCES deploy"

clean:
		rm -R ./test_php/base/data
		vagrant destroy

init:
		vagrant up
		ansible-playbook -i hosts init.yml

deploy:
		@echo "Instances $(inst)"
		rm -R ./test_php/base/data
		mkdir ./test_php/base/data
		chmod +x nginx_tmp.sh
		chmod +x compose_tmp.sh
		./nginx_tmp.sh $(inst)
		./compose_tmp.sh $(inst)
		ansible-playbook -i hosts deploy.yml

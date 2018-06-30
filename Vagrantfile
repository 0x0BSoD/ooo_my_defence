# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    config.vm.define "base" do |base|
        base.vm.box = "ubuntu/trusty64"
        base.vm.network "private_network", ip: "192.168.10.2"
        base.vm.hostname = "base"
        base.vm.define "base"
        base.vm.provider :virtualbox do |vb|
            vb.name = "base"
            vb.memory = 512
        end
        id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
        config.vm.provision "copy ssh public key", type: "shell",
          inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"
        # base.vm.provision "shell", inline: <<-SHELL
        #     apt update
        #     apt full-upgrade -y
        # SHELL
    end

    config.vm.define "balancer" do |balancer|
        balancer.vm.box = "ubuntu/trusty64"
        balancer.vm.network "private_network", ip: "192.168.10.3"
        balancer.vm.hostname = "balancer"
        balancer.vm.define "balancer"
        balancer.vm.provider :virtualbox do |vb|
            vb.name = "balancer"
            vb.memory = 512
        end
        id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
        config.vm.provision "copy ssh public key", type: "shell",
          inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"
        # balancer.vm.provision "shell", inline: <<-SHELL
        #     apt update
        #     apt full-upgrade -y
        # SHELL
    end

    config.vm.define "backend" do |backend|
        backend.vm.box = "ubuntu/trusty64"
        backend.vm.network "private_network", ip: "192.168.10.10"
        backend.vm.hostname = "backend"
        backend.vm.define "backend"
        backend.vm.provider :virtualbox do |vb|
            vb.name = "backend"
            vb.memory = 512
        end
        id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
        config.vm.provision "copy ssh public key", type: "shell",
          inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"        
        # backend.vm.provision "shell", inline: <<-SHELL
        #     apt update
        #     apt full-upgrade -y
        # SHELL
    end
end

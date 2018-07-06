# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    config.vm.define "backend" do |backend|
        backend.vm.box = "ubuntu/xenial64"
        backend.vm.network "private_network", ip: "192.168.98.10"
        backend.vm.hostname = "backend"
        backend.vm.define "backend"
        backend.vm.provider :virtualbox do |vb|
            vb.name = "backend"
            vb.memory = 2048
        end
        id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
        config.vm.provision "copy ssh public key", type: "shell",
          inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"
        backend.vm.provision "shell", inline: <<-SHELL
            apt update
            apt full-upgrade -y
            apt install python -y
        SHELL
    end
end

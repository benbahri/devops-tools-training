# -*- mode: ruby -*-
# vi: set ft=ruby :

$script_inject_pk =<<-'SCRIPT'
    cat /vagrant/setup/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    cat /vagrant/setup/hosts >> /etc/ansible/hosts
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define "ansible-master" do |subconfig|
    subconfig.vm.box = "centos/7"
    subconfig.vm.hostname = "ansible"
    subconfig.vm.network :private_network, ip: "10.0.0.10"
    #subconfig.vm.network "forwarded_port", guest: 80, host: 8080
    subconfig.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
    subconfig.vm.provider "virtualbox" do |vb|
	#	vb.memory = "2048"
	end
    subconfig.vbguest.auto_update = false
    subconfig.vm.provision "file", source: "setup/id_rsa", destination: ".ssh/id_rsa"
    subconfig.vm.provision :shell, path: 'setup/lab_setup.sh'
  end

  (1..1).each do |i|
    config.vm.define "ansible-node0#{i}" do |subconfig|
      subconfig.vm.box = "centos/7"
      subconfig.vm.hostname = "node0#{i}"
      subconfig.vm.network :private_network, ip: "10.0.0.2#{i}"
      subconfig.vm.network "forwarded_port", guest: 80, host: "808#{i}"
      subconfig.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
      subconfig.vbguest.auto_update = false
      subconfig.vm.provision "shell", inline: $script_inject_pk
    end
  end

   (1..0).each do |i|
    config.vm.define "ansible-ubuntu0#{i}" do |subconfig|
      subconfig.vm.box = "ubuntu/xenial64"
      subconfig.vm.hostname = "ubuntu0#{i}"
      subconfig.vm.network :private_network, ip: "10.0.0.3#{i}"
      subconfig.vm.network "forwarded_port", guest: 80, host: "809#{i}"
      subconfig.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
      subconfig.vbguest.auto_update = false
      subconfig.vm.provision "shell", inline: $script_inject_pk
    end
  end

end

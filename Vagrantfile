Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|


  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  config.ssh.insert_key = false

    (1..7).each do |number|
        config.vm.box = "centos/7"
        config.vm.define "centos#{number}" do |node|
            node.vm.network "private_network", ip: "192.168.100.21#{number}"
            node.vm.hostname = "centos#{number}"
        end
    end

    config.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end

    #copies ssh key to from host specified key to target vm destination
    config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"

    #run shell command to append pub key and install salt minion
    config.vm.provision "shell", inline: <<-SHELL
      cat ~vagrant/.ssh/me.pub >> ~vagrant/.ssh/authorized_keys
      sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
      sudo yum install -y salt-minion
      sudo sed -i 's/^#master: salt/master: 192.168.100.211/' /etc/salt/minion
      sudo systemctl enable salt-minion
    SHELL

    (1..3).each do |number|
        config.vm.box = "ubuntu/xenial64"
        config.vm.define "ubuntu#{number}" do |node|
            node.vm.network "private_network", ip: "192.168.100.22#{number}"
            node.vm.hostname = "ubuntu#{number}"
        end
    end

    config.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end

    #copies ssh key to from host specified key to target vm destination
    config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"

    #run shell command to append pub key and install salt minion
    config.vm.provision "shell", inline: <<-SHELL
      cat ~vagrant/.ssh/me.pub >> ~vagrant/.ssh/authorized_keys
      sudo add-apt-repository ppa:saltstack/salt
      sudo apt-get update
      sudo apt-get install salt-minion
      sudo sed -i 's/^#master: salt/master: 192.168.100.211/' /etc/salt/minion
      sudo systemctl enable salt-minion
    SHELL

    #config.vm.provision "ansible" do |ansible|
    #  ansible.verbose = "v"
    #  ansible.playbook = "playbook.yml"
    #end
end

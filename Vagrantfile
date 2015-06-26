# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Set the number of webserver nodes below
NUM_NODES = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.define "service-discovery" do |disc|
    disc.vm.hostname = "service-discovery"
    disc.vm.network "private_network", ip: "192.168.50.99"
    disc.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision/service-discovery.yml"
    end
  end

  (1..NUM_NODES).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "node#{i}"
      node.vm.network "private_network", type: "dhcp"
      node.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision/webnodes.yml"
      end
    end
  end

  config.vm.define "lbnode" do |lb|
    lb.vm.hostname = "lbcore"
    lb.vm.network "private_network", type: "dhcp"
    lb.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision/lb.yml"
    end
  end
  
end

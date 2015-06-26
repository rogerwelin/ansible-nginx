# ansible-nginx

## Synopsis
This project uses vagrant + ansible (and some homecooked scripting skills) to dynamically create a nginx round-robin load balancer cluster with any number of nodes (default 3) that connects
to the load balancer using etcd as a service discovery

## Requirements
* Vagrant must be installed on the host machine
* Ansible must be installed on the host machine
* Host machine needs to reach https://github.com (for fetching etcd)
* Port 9999 on host machine needs to be unused, otherwise change this port in Vagrantfile

## Instructions
* To change number of nginx nodes used by the load balancer, change the value of the variable 'NUM_NODES' in Vagrantfile
* vagrant up
* run ruby script to calculate the distributed load across the nodes:
```shell
./epicrubylb.rb
Command-line utility for calculating even lb ngix round-robin load.

  ./epicrubylb.rb [-n Number of requests to lb]

  Example: ./epicrubylb.rb -n 100

  Expected output:
  node1: 50
  node2: 50
    -n, --num-requests [Requests]    The total number of request sent to lb
    -h, --help                       help
```

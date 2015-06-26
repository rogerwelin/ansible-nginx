#!/bin/bash

HOST=$(hostname)
GET_IP=$(ifconfig eth1 | grep "inet addr" | awk '{print $2}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

#register to etcd
curl -s http://192.168.50.99:4001/v2/keys/webservers/${HOST} -XPUT -d value="$GET_IP"

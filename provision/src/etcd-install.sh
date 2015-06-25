#!/bin/bash

curl -sL  https://github.com/coreos/etcd/releases/download/v2.1.0-alpha.1/etcd-v2.1.0-alpha.1-linux-amd64.tar.gz -o etcd.tar.gz && tar -xvf etcd.tar.gz -C /usr/local/bin/ --strip-components=1


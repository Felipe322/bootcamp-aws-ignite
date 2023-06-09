#!/bin/bash

yum update -y
curl -sL https://rpm.nodesource.com/setup_14.x | bash -
yum install -y nodejs git
git clone https://github.com/Felipe322/bootcamp-aws-ignite.git
cd bootcamp-aws-ignite/code/week-2/user_data/node_server.js
node helloworld.js
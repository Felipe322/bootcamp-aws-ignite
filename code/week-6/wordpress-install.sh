#!/bin/bash

apt update
apt -y install \
ca-certificates \
curl git \
gnupg \
lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
git clone https://github.com/Felipe322/bootcamp-aws-ignite.git
cd bootcamp-aws-ignite/code/week-6/
docker compose up -d
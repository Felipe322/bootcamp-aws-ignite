#!/bin/bash

yum update -y
yum install -y python3 python3-pip git
sudo yum install postgresql-devel
git clone https://github.com/Felipe322/bootcamp-aws-ignite.git
cd bootcamp-aws-ignite/code/week-3/user_data/
pip3 install psycopg2-binary
pip3 install psycopg2

python3 stress_test.py
#!/bin/bash

yum update -y
yum install -y python3 git
git clone https://github.com/Felipe322/bootcamp-aws-ignite.git
cd bootcamp-aws-ignite/code/week-3/user_data/
python3 stress_test.py
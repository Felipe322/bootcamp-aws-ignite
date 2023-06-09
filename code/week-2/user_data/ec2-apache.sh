#!/bin/bash

yum update -y
yum install -y httpd
echo 'Bootcamp AWS Ignite 2023 Apache!' > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
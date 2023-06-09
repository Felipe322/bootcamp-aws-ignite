#!/bin/bash

# Varibales for EC2 instance
AMI_ID="ami-0715c1897453cabd1"
INSTANCE_TYPE="t2.micro"
KEY_NAME="bootcamp-app"
TAG_APACHE="ResourceType=instance,Tags=[{Key=Name,Value=ApacheInstance}]"
TAG_NODE="ResourceType=instance,Tags=[{Key=Name,Value=NodeInstance}]"
TAG_PYTHON="ResourceType=instance,Tags=[{Key=Name,Value=PythonInstance}]"
REGION="us-east-1"

# Variables Security Group
SECURITY_GROUP_NAME="bootcamp-aws-ignite"
SG_DESCRIPTION="Bootcamp AWS-Ignite"
VPC_ID="vpc-0e07703dec4c5175f"

# Protocols
PROTOCOL_TCP="tcp"

# Port variables
PORT_HTTP=80
PORT_HTTPS=443
PORT_SSH=22

#Variables para obtener Ip actual
MY_IP=$(curl -s http://checkip.amazonaws.com)
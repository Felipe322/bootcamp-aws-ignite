#!/bin/bash

## Varibales for EC2 instance
AMI_ID="ami-0715c1897453cabd1"
INSTANCE_TYPE="t2.micro"
KEY_NAME="bootcamp-app"
#Changed
TAG="ResourceType=instance,Tags=[{Key=Name,Value=app-bootcamp}]"
REGION="us-east-1"

# Variables Security Group
SECURITY_GROUP_NAME="bootcamp-aws-ignite"
SG_DESCRIPTION="Bootcamp AWS-Ignite"
VPC_ID="vpc-0e07703dec4c5175f"

# Protocols
PROTOCOL_TCP="tcp"

# Port variables
PORT_HTTP=80
PORT_SSH=22
PORT_MYSQL=3306

#Variables para obtener Ip actual
MY_IP=$(curl -s http://checkip.amazonaws.com)


## Variables for Aurora for MySQL
DB_CLUSTER_IDENTIFIER="bootcamp-cluster-db"
ENGINE="aurora-mysql"
ENGINE_VERSION="8.0.mysql_aurora.3.02.0"
MASTER_USERNAME="bootcamp"
MASTER_USER_PASSWORD="oM!4X1tgom"
SERVERLESS_V2_SCALING_CONFIGURATION="MinCapacity=1,MaxCapacity=4"
BACKUP_RETENTION_PERIOD=1
SECURITY_GROUP_IDS=$RDS_GROUP_ID

DB_INSTANCE_IDENTIFIER="bootcamp-db"
DB_INSTANCE_CLASS="db.serverless"

# Variables Security Group
RDS_GROUP_NAME="rds-bootcamp-sg"
RDS_GROUP_DESCRIPTION="DB Bootcamp security group"
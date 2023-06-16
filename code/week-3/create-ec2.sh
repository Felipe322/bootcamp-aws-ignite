#!/bin/bash

source ./variables.sh

echo "Creando Key pair: bootcamp-app"

aws ec2 create-key-pair --key-name bootcamp-app --query 'KeyMaterial' --output text > bootcamp-app.pem

chmod 400 bootcamp-app.pem

echo "Creando instancias EC2..."

# Crear la primera instancia EC2 con Python
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP_NAME \
    --tag-specifications $TAG \
    --region $REGION \
    --user-data "file://user_data/ec2-python.sh") &

# Esperar hasta que la instancia esté en estado 'running'
aws ec2 wait instance-running --region $REGION --instance-ids $INSTANCE_ID

echo "Las instancias EC2 se han creado correctamente."

# Obtener la dirección IP pública de la instancia
PUBLIC_IP=$(aws ec2 describe-instances \
  --region $REGION \
  --instance-ids $INSTANCE_ID \
  --output text \
  --query 'Reservations[0].Instances[0].PublicIpAddress')

echo "IP pública: $PUBLIC_IP obtenida de la instancia $INSTANCE_ID."
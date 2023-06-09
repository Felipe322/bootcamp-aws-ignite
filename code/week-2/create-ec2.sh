#!/bin/bash

source ./variables.sh

echo "Creando Key pair: bootcamp-app"

aws ec2 create-key-pair --key-name bootcamp-app > bootcamp-app.pem

chmod 400 bootcamp-app.pem

echo "Creando instancias EC2..."

# Crear la primera instancia EC2 con Apache
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP_NAME \
    --tag-specifications $TAG_APACHE \
    --region $REGION \
    --user-data "file://user_data/ec2-apache.sh") &

# Crear la segunda instancia EC2 con Node.js
INSTANCE_ID_NODE=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP_NAME \
    --tag-specifications $TAG_NODE \
    --region $REGION \
    --user-data "file://user_data/ec2-node.sh") &

# Crear la tercera instancia EC2 con Python
INSTANCE_ID_PYTHON=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP_NAME \
    --tag-specifications $TAG_PYTHON \
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


# Obtener la dirección IP pública de la instancia
PUBLIC_IP_NODE=$(aws ec2 describe-instances \
  --region $REGION \
  --instance-ids $INSTANCE_ID_NODE \
  --output text \
  --query 'Reservations[0].Instances[0].PublicIpAddress')

echo "IP pública: $PUBLIC_IP_NODE obtenida de la instancia $INSTANCE_ID_NODE."


# Obtener la dirección IP pública de la instancia
PUBLIC_IP_PYTHON=$(aws ec2 describe-instances \
  --region $REGION \
  --instance-ids $INSTANCE_ID_PYTHON \
  --output text \
  --query 'Reservations[0].Instances[0].PublicIpAddress')

echo "IP pública: $PUBLIC_IP_PYTHON obtenida de la instancia $INSTANCE_ID_PYTHON."


echo "Esperando estatus OK de instancia $INSTANCE_ID (Initializing...)."

# Esperar hasta que la instancia esté en estado 'running' antes de conectarse por SSH
aws ec2 wait instance-status-ok --region $REGION --instance-ids $INSTANCE_ID

echo "Creando IP elastica."

#Creamos Ip elastica
# allocation=$(aws ec2 allocate-address --domain vpc)

# readarray -t ip_address < <(aws ec2 allocate-address --domain vpc --query 'PublicIp' --output json)


echo "Asociando IP elastica a Instancia: $INSTANCE_ID"

#Asociar Ip elastica a Instancia Ec2
# aws ec2 associate-address --instance-id "$INSTANCE_ID" --public-ip "${ip_address[0]}"
# aws ec2 associate-address --instance-id "$INSTANCE_ID" --public-ip "${ip_address[0]}"i-089cf1f4cf42fce9d



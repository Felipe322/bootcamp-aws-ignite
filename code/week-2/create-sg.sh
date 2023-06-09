#!/bin/bash

source ./variables.sh

GROUP_ID=$(aws ec2 create-security-group \
    --group-name "$SECURITY_GROUP_NAME" \
    --description "$SG_DESCRIPTION" \
    --vpc-id "$VPC_ID" \
    --output text \
    --query 'GroupId')

echo "Se ha creado el grupo de seguridad: $SECURITY_GROUP_NAME, con ID: $GROUP_ID."

# Habilitar el acceso SSH (puerto 22)
aws ec2 authorize-security-group-ingress \
    --group-id "$GROUP_ID" \
    --protocol $PROTOCOL_TCP \
    --port $PORT_SSH \
    --cidr $MY_IP/32

echo "Se ha habilitado el acceso SSH por el puerto 22 en el grupo de seguridad $SECURITY_GROUP_NAME."

# Habilitar el acceso SSH (puerto 22)
aws ec2 authorize-security-group-ingress \
    --group-id "$GROUP_ID" \
    --protocol $PROTOCOL_TCP \
    --port $PORT_HTTP \
    --cidr $MY_IP/32

echo "Se ha habilitado el acceso HTTP por el puerto 80 en el grupo de seguridad $SECURITY_GROUP_NAME."

# Habilitar el acceso SSH (puerto 22)
aws ec2 authorize-security-group-ingress \
    --group-id "$GROUP_ID" \
    --protocol $PROTOCOL_TCP \
    --port $PORT_HTTPS \
    --cidr $MY_IP/32

echo "Se ha habilitado el acceso HTTPS por el puerto 443 en el grupo de seguridad $SECURITY_GROUP_NAME."
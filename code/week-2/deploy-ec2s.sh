#!/bin/bash

source ./variables.sh

if aws ec2 describe-security-groups --group-name "$SECURITY_GROUP_NAME" >/dev/null 2>&1; then
    echo "El grupo de seguridad $SECURITY_GROUP_NAME ya existe."
else
    source ./create-sg.sh
fi   

INSTANCE_EXISTS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=ApacheInstance")

if [[ $(echo "$INSTANCE_EXISTS" | jq -r '.Reservations | length') -gt 0 ]]; then
    echo "Instancias EC2 ya existen."
else
    source ./create-ec2.sh
fi   

echo "Proceso finalizado."
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

# Habilitar el acceso HTPP (puerto 80)
aws ec2 authorize-security-group-ingress \
    --group-id "$GROUP_ID" \
    --protocol $PROTOCOL_TCP \
    --port $PORT_HTTP \
    --cidr $MY_IP/32

echo "Se ha habilitado el acceso HTTP por el puerto 80 en el grupo de seguridad $SECURITY_GROUP_NAME."


# Creación del security group del RDS
if aws ec2 describe-security-groups --group-names "$RDS_GROUP_NAME" >/dev/null 2>&1; then
  echo "El grupo de seguridad $RDS_GROUP_NAME ya existe. No es necesario crearlo."
else
  # Creando el security group
  RDS_GROUP_ID=$(aws ec2 create-security-group \
    --group-name "$RDS_GROUP_NAME" \
    --description "$RDS_GROUP_DESCRIPTION" \
    --vpc-id "$VPC_ID" \
    --output text \
    --query 'GroupId')

  echo "El security group $RDS_GROUP_ID ($RDS_GROUP_NAME) ha sido creado exitosamente."

    # Habilitando el acceso MYSQL (puerto 3306)
  aws ec2 authorize-security-group-ingress \
        --group-id "$RDS_GROUP_ID" \
        --protocol tcp \
        --port $PORT_MYSQL \
        --cidr $MY_IP/32 \
        --source-group $GROUP_ID

    echo "Se ha habilitado el acceso a MySQL en el puerto 3306 en el grupo de seguridad $RDS_GROUP_NAME."

fi


## Create and assing policy
# aws iam create-policy --policy-name bootcampIgniteRDSFullAccessPolicy --policy-document file://bootcampIgniteRDSFullAccessPolicy.json

# aws iam attach-user-policy --user-name fdelgado --policy-arn arn:aws:iam::XXXXXXXXXX:policy/bootcampIgniteRDSFullAccessPolicy
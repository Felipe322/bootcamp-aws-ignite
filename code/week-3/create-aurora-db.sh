#!/bin/bash

# Obtener las variables iniciales
source ./variables.sh

# Create Aurora for MySQL
aws rds create-db-cluster \
  --db-cluster-identifier $DB_CLUSTER_IDENTIFIER \
  --region $REGION \
  --engine $ENGINE \
  --engine-version $ENGINE_VERSION \
  --serverless-v2-scaling-configuration $SERVERLESS_V2_SCALING_CONFIGURATION \
  --master-username $MASTER_USERNAME \
  --master-user-password $MASTER_USER_PASSWORD \
  --backup-retention-period $BACKUP_RETENTION_PERIOD \
  --vpc-security-group-ids $SECURITY_GROUP_IDS
echo "La RDS cluster ($DB_CLUSTER_IDENTIFIER) se está creando..."

# Esperar hasta que la instancia esté en estado 'available'
aws rds wait db-cluster-available --region $REGION --db-cluster-identifier $DB_CLUSTER_IDENTIFIER
echo "La RDS cluster ($DB_CLUSTER_IDENTIFIER) se ha creado exitosamente."

aws rds create-db-instance \
  --db-instance-identifier $DB_INSTANCE_IDENTIFIER \
  --db-cluster-identifier $DB_CLUSTER_IDENTIFIER \
  --db-instance-class $DB_INSTANCE_CLASS \
  --engine $ENGINE \
  --region $REGION \
  --publicly-accessible
echo "La RDS instance ($DB_INSTANCE_IDENTIFIER) se está creando..."

# Esperar hasta que la instancia esté en estado 'available'
aws rds wait db-instance-available --region $REGION --db-instance-identifier $DB_INSTANCE_IDENTIFIER
echo "La RDS instance ($DB_INSTANCE_IDENTIFIER) se ha creado exitosamente."

#!/bin/sh
export AWS_ACCESS_KEY_ID=$AWS_SECRET_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_REGION
psql -U $POSTGRES_USER -c "SELECT pg_terminate_backend (pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$POSTGRES_DB';"
psql -U $POSTGRES_USER -c "drop database $POSTGRES_DB;"
psql -U $POSTGRES_USER -c "create database $POSTGRES_DB;"
echo "Backing up from s3 for ${POSTGRES_DB} database."
aws s3 cp s3://$S3_DOWNLOAD_BUCKET/${DOWNLOAD_FILE_NAME} dump.sql.gz
gzip -d dump.sql.gz
echo "Restoring ${DOWNLOAD_FILE_NAME}"
psql -U $POSTGRES_USER -d $POSTGRES_DB < dump.sql
echo "Restore complete"
rm dump.sql


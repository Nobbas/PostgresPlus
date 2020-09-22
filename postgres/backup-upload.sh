
#!/bin/bash

. /root/project_env.sh

export AWS_ACCESS_KEY_ID=$AWS_SECRET_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_REGION
echo "Creating dump of ${POSTGRES_DB} database."
pg_dump -U $POSTGRES_USER $POSTGRES_DB | gzip > backup.sql.gz
echo "Uploading dump to $S3_UPLOAD_BUCKET"
cat backup.sql.gz | aws s3 cp - s3://$S3_UPLOAD_BUCKET/${POSTGRES_DB}_$(date +"%Y-%m-%dT%H:%M:%SZ").sql.gz || exit 2
echo "SQL backup uploaded successfully"
rm backup.sql.gz
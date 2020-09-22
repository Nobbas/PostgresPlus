# PostgresPlus
Advancing Postgres with AutoBackups, Replication Database Setup, and Logical Decoding.

## `default.env` -> `.env`
Create a new file in the root directory and name it as `.env` with the contents of `default.env`. This file contains all the environment variables needed to setup the Postgres Container. Set the configurations as per your requirement.

## Start Postgres Service
```sh
$ docker-compose up -d
```
## Setting up backup cron:
Before starting up the service, make sure you have configured the value `true` for `SETUP_CRON` Environment Variable.
The cron should be set up automatically as you run the docker-compose command (by default the task is scheduled to run after every 3 hours).

You can also use the standalone backup-upload script to upload the backup to s3 at any time.
```sh
$ docker exec -it postgres_service bin/bash backup-upload.sh 
```


## Downloading the latest backup to the running Postgres instance:
```sh
$ docker exec -it postgres_service bin/bash backup-download-latest.sh 
```

## Downloading the specified backup file to the running Postgres instance:
Set the `DOWNLOAD_FILE_NAME`environment variable
```sh
# if you want to overwrite the DOWNLOAD_FILE_NAME env variable
$ docker exec -e DOWNLOAD_FILE_NAME='<file_name>' postgres_service /backup-download.sh

# or if the correct file name is already set
$ docker exec -it postgres_service bin/bash backup-download.sh 
```

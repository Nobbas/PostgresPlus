# PostgresPlus
Advancing Postgres with AutoBackups, Replication Database Setup, Logical Decoding
## `default.env` -> `.env`
Create a new file in the root directory and name it as `.env` with the contents of `default.env`. This file contains all the environment variables needed to setup the Postgres Container. Set the configurations as per your requirement.

## Setup Postgres
```sh
$ docker-compose up -d
```
## Setting up backup cron:
Before starting up the service with the above command, make sure you have configured the value `true` for `SETUP_CRON` Environment Variable.
The cron should be setup automatically as you run the docker-compose command (by default the task is scheduled to run after every 3 hours).

## Downloading the latest backup to the running Postgres instance:
```sh
$ docker exec -it postgres_service bin/bash backup-download-latest.sh 
```

## Downloading the specified backup file to the running Postgres instance:
Set the `DOWNLOAD_FILE_NAME`environment variable
```sh
# if you want to ovrwrite the DOWNLOAD_FILE_NAME env variable
$ docker exec -it postgres_service bin/bash export DOWNLOAD_FILE_NAME=<file_name> 

$ docker exec -it postgres_service bin/bash backup-download.sh 
```

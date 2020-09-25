FROM postgres:11.4
LABEL maintainer="sahil@koverhoop.com"
LABEL version="0.1"

RUN apt-get update && apt-get install -y python-pip
RUN pip install awscli
RUN apt-get -y install curl nano
RUN apt-get update && apt-get -y install cron

COPY backup-upload.sh /backup-upload.sh
COPY backup-download.sh /backup-download.sh
COPY backup-download-latest.sh /backup-download-latest.sh
COPY start-cron.sh /start-cron.sh
COPY cron-task /etc/cron.d/cron-task

RUN chmod 777 backup-upload.sh
RUN chmod 777 backup-download.sh
RUN chmod 777 backup-download-latest.sh
RUN chmod 777 start-cron.sh
RUN chmod 777 /etc/cron.d/cron-task

RUN crontab /etc/cron.d/cron-task
RUN touch /var/log/cron.log

WORKDIR /workspace

COPY wal2json-master.zip wal2json-master.zip

RUN apt-get update && \
  apt-get install -y wget unzip make gcc postgresql-server-dev-11 && \
  wget https://github.com/gianmarcotoso/temporal_tables/archive/master.zip && \
  unzip master.zip && \
  cd temporal_tables-master && \
  make && \
  make install && \
  cd .. && \
  unzip wal2json-master.zip && \
  cd wal2json-master && \
  make && \
  make install && \
  apt-get remove -y unzip wget make gcc postgresql-server-dev-11 && \
  cd .. && \
  rm -rf ./*
  
ENTRYPOINT /start-cron.sh && /docker-entrypoint.sh postgres

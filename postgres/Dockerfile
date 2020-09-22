FROM postgres:11.4

RUN apt-get update && apt-get install -y python-pip
RUN pip install awscli
RUN apt-get -y install curl nano
RUN apt-get update && apt-get -y install cron

COPY backup-upload.sh /backup-upload.sh
COPY backup-download.sh /backup-download.sh
COPY start-cron.sh /start-cron.sh
COPY hello-cron /etc/cron.d/hello-cron

RUN chmod 777 backup-upload.sh
RUN chmod 777 backup-download.sh
RUN chmod 777 start-cron.sh
RUN chmod 777 /etc/cron.d/hello-cron

RUN crontab /etc/cron.d/hello-cron
RUN touch /var/log/cron.log



ENTRYPOINT /start-cron.sh && /docker-entrypoint.sh postgres

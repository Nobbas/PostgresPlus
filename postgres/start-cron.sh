if [ $SETUP_CRON = true ]; then
    printenv | grep -v "affinity:container" | sed 's/^\(.*\)$/export \1/g' > /root/project_env.sh
    chmod 777 /root/project_env.sh
    cron
fi
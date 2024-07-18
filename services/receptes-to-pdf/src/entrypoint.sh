#!/usr/bin/bash

function cleanup {
    echo "Executing clean-up code"
    if mountpoint -q receptes; then { echo "Umounting receptes"; umount receptes; } fi
    if mountpoint -q receptes-pdf; then { echo "Umounting receptes-pdf"; umount receptes-pdf; } fi
}

function force_umount {
    if [ -f /var/run/mount.davfs/opt-$1.pid ]; then
        if mountpoint -q $1; then
            echo "Umounting $1"
            umount $1
        else
            echo "Mount process ended irregularly, removing /var/run/mount.davfs/opt-$1.pid"
            rm /var/run/mount.davfs/opt-$1.pid
        fi
    fi
}

trap cleanup SIGTERM SIGINT SIGQUIT SIGHUP ERR

# echo "trust_ca_cert ${DAV_CA_CERT_NAME}" >> /etc/davfs2/davfs2.conf
echo "${DAV_SERVER}/${DAV_SERVER_INDIR} ${DAV_SERVER_USER} ${DAV_SERVER_PASS}" > /etc/davfs2/secrets
echo "${DAV_SERVER}/${DAV_SERVER_OUTDIR} ${DAV_SERVER_USER} ${DAV_SERVER_PASS}" >> /etc/davfs2/secrets

mkdir -p receptes receptes-pdf /config
force_umount receptes
mountpoint -q receptes || { echo "Mounting ${DAV_SERVER}/${DAV_SERVER_INDIR}"; mount -t davfs ${DAV_SERVER}/${DAV_SERVER_INDIR} receptes -o ro; }
if [ $? -ne 0 ]; then { echo "Failed to mount, aborting."; exit 1; } fi
force_umount receptes-pdf
mountpoint -q receptes-pdf || { echo "Mounting ${DAV_SERVER}/${DAV_SERVER_OUTDIR}"; mount -t davfs ${DAV_SERVER}/${DAV_SERVER_OUTDIR} receptes-pdf; }
if [ $? -ne 0 ]; then { echo "Failed to mount, aborting."; exit 1; } fi

# setup cron job
env >> /etc/environment
rm -rf /etc/cron.*/*
echo "10 * * * * root cd '`pwd`' && doit run -v 2 -r console --db-file=/config/.doit.db >/proc/1/fd/1 2>/proc/1/fd/2" > /etc/crontab
cat /etc/crontab
cron -f -l 2

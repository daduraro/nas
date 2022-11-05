#!/usr/bin/bash

echo "trust_ca_cert ${DAV_CA_CERT_NAME}" >> /etc/davfs2/davfs2.conf
echo "${DAV_SERVER}/${DAV_SERVER_INDIR} ${DAV_SERVER_USER} ${DAV_SERVER_PASS}" > /etc/davfs2/secrets
echo "${DAV_SERVER}/${DAV_SERVER_OUTDIR} ${DAV_SERVER_USER} ${DAV_SERVER_PASS}" >> /etc/davfs2/secrets

mkdir -p receptes receptes-pdf /config
mountpoint -q receptes || { echo "Mounting ${DAV_SERVER}/${DAV_SERVER_INDIR}"; mount -t davfs ${DAV_SERVER}/${DAV_SERVER_INDIR} receptes -o ro; }
if [ $? -ne 0 ]; then { echo "Failed to mount, aborting."; exit 1; } fi
mountpoint -q receptes-pdf || { echo "Mounting ${DAV_SERVER}/${DAV_SERVER_OUTDIR}"; mount -t davfs ${DAV_SERVER}/${DAV_SERVER_OUTDIR} receptes-pdf; }
if [ $? -ne 0 ]; then { echo "Failed to mount, aborting."; exit 1; } fi

while true;
do
    echo "Executing tasks..."
    doit run -v 2 -r console --db-file=/config/.doit.db
    echo "Sleep 10s"
    sleep 10
done

#!/usr/bin/bash
cd "$(dirname "$0")"
BACKUP_FOLDER=backup/$(date +%Y-%m-%d)
echo "creating ${BACKUP_FOLDER}"
mkdir -p ${BACKUP_FOLDER}
docker compose exec db mysqldump --user=root --password=${DB_PASSWORD} --opt --single-transaction ccnet_db | gzip > ${BACKUP_FOLDER}/ccnet_db.sql.gz
docker compose exec db mysqldump --user=root --password=${DB_PASSWORD} --opt --single-transaction seafile_db | gzip > ${BACKUP_FOLDER}/seafile_db.sql.gz
docker compose exec db mysqldump --user=root --password=${DB_PASSWORD} --opt --single-transaction seahub_db | gzip > ${BACKUP_FOLDER}/seahub_db.sql.gz

docker run --rm -e "DRY_RUN=false" -v ./backup:/archive daduraro/docker-rotate-backups:latest

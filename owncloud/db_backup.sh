#!/usr/bin/bash
docker compose exec mariadb /usr/bin/mysqldump -u root --password=owncloud --single-transaction owncloud > backups/owncloud_$(date +%Y%m%d).sql

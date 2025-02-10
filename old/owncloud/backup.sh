#!/usr/bin/bash
pushd "$(dirname "${BASH_SOURCE[0]}")"
docker compose exec owncloud occ maintenance:mode --on
docker compose exec mariadb /usr/bin/mysqldump -u root --password=owncloud --single-transaction owncloud | gzip > backup/$(date +%Y-%m-%d).gz
docker compose exec owncloud occ maintenance:mode --off
find backup -mtime +11 -type f -delete
popd
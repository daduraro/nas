#!/usr/bin/bash
pushd "$(dirname "${BASH_SOURCE[0]}")"
docker compose stop
docker compose run -v $PWD/backup:/baserow/backups backend backup -f /baserow/backups/$(date +%Y%m%d).tar.gz 
docker compose start
find backup -mtime +11 -type f -delete
popd
# Upgrading owncloud on Docker

1. Put ownCloud into maintenance mode with the following command:

```console
$ docker compose exec owncloud occ maintenance:mode --on
```

2. Create DB backup:

```console
$ docker compose exec mariadb /usr/bin/mysqldump -u root --password=owncloud --single-transaction owncloud > backups/owncloud_$(date +%Y%m%d).sql
```

3. Shutdown the containers:

```console
$ docker compose down
```

4. Update tags on `docker-compose.yml`.

5. Start docker again:
```console
$ docker compose up -d
$ docker compose exec owncloud occ maintenance:mode --off
$ docker compose exec owncloud occ upgrade
```

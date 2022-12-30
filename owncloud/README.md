# Upgrading owncloud on Docker

1. Put ownCloud into maintenance mode with the following command:

```console
$ docker compose exec owncloud occ maintenance:mode --on
```

2. Create DB backup:

```console
$ ./db_backup.sh
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
```

# README

The volume for the postgres socket is created local to this directory (./postgresql).
After the container is up the socket needs to be symlinked to the expected location on the host filesystem.
This is a workaround for not being able to create volumes in dirs controlled by root while running rootless docker.
```bash
docker compose up -d
sudo ln -s $PWD/postgresql /run/postgresql
```
Note: Needs to be added as a sudo crontab entry to be present after reboots.
```
@reboot ln -s ${FULLY_QUALIFIED_PATH}/postgresql /run/postgresql
```

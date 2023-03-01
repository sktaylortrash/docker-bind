forked from [windoac/bind](https://github.com/WindoC/docker-bind)

## Updated features for this fork

1. Cron support: Will retain the current crontab content/jobs when the container stops and load it when starts.
2. Root password can be set using environment variable:  ROOT_PASSWORD : Password

## info
dockerhub forked from WindoC/docker-bind
https://github.com/WindoC/docker-bind

Dockerfile see
https://github.com/sktaylortrash/docker-bind/blob/master/Dockerfile

docker-compose.yml
```yaml
version: "3.2"
services:
  
  bind:
    image: polargeek/bind-webmin:latest
    container_name: bind
    volumes:
      - ./data:/data
    ports:
      - 10000:10000
      - 53:53
      - 53:53/udp
    environment:
      TZ : America/Regina
      ROOT_PASSWORD : Password
    restart: unless-stopped
```

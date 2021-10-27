# Satisfactory Dedicated Server

## Disclaimer

This server implementation is not official.

## Description

Dedicated Server for Satisfactory using Docker, and optionally Docker-Compose.  
Built from scratch to be the smallest Satisfactory Dedicated Server around!

## Links

Source:

- [GitHub](https://github.com/Renegade-Master/satisfactory-dedicated-server)
- [DockerHub](https://hub.docker.com/r/renegademaster/satisfactory-dedicated-server)

Resource links:

- [Satisfactory Dedicated Server Wiki](https://satisfactory.fandom.com/wiki/Dedicated_servers)
- [Satisfactory Homepage](https://www.satisfactorygame.com/)
- [Steam Store Page](https://store.steampowered.com/app/526870/satisfactory)
- [Epic Games Store Page](https://www.epicgames.com/store/en-US/p/satisfactory)

## Instructions

### Docker

The following are instructions for running the server using the Docker image.

1. Acquire the image locally:
    * Pull the image from DockerHub:

      ```shell
      docker pull renegademaster/satisfactory-dedicated-server:<tag>
      ```
    * Or alternatively, build the image:

      ```shell
      git clone https://github.com/Renegade-Master/satisfactory-dedicated-server.git \
          && cd satisfactory-dedicated-server

      docker build -t renegademaster/satisfactory-dedicated-server:<tag> -f docker/satisfactory-server.Dockerfile .
      ```

2. Run the container:

   ```shell
   mkdir SatisfactoryDedicatedServer SatisfactorySaveGames

   docker run --detach \
       --mount type=bind,source="$(pwd)/SatisfactoryDedicatedServer",target=/home/steam/SatisfactoryDedicatedServer \
       --mount type=bind,source="$(pwd)/SatisfactorySaveGames",target=/home/steam/.config/Epic/FactoryGame/Saved/SaveGames \
       --publish 15777:15777/udp --publish 15000:15000/udp --publish 7777:777/udp \
       --name satisfactory-server \
       renegademaster/satisfactory-dedicated-server:<tag>
   ```

### Docker-Compose

The following are instructions for running the server using Docker-Compose.

1. Download the repository:

   ```shell
   git clone https://github.com/Renegade-Master/satisfactory-dedicated-server.git \
       && cd satisfactory-dedicated-server
   ```
2. Run the following command:

   ```shell
   docker-compose up -d
   ```

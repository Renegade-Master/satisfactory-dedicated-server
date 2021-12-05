# Satisfactory Dedicated Server

## Disclaimer

**Note:** This image is not officially supported by Valve, nor by Coffee Stain Studios

If issues are encountered, please report them on
the [GitHub repository](https://github.com/Renegade-Master/satisfactory-dedicated-server/issues/new/choose)

## Description

Dedicated Server for Satisfactory using Docker, and optionally Docker-Compose.  
Built almost from scratch to be the smallest Satisfactory Dedicated Server around!

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
   ***Note**: Arguments inside square brackets are optional*
    - Game Version [`public`, `experimental`]
    - Maximum players [*Any numerical value is accepted, but more than 16 is not advised*]

   ```shell
   mkdir SatisfactoryDedicatedServer SatisfactorySaveGames

   docker run --detach \
       --mount type=bind,source="$(pwd)/SatisfactoryDedicatedServer",target=/home/steam/SatisfactoryDedicatedServer \
       --mount type=bind,source="$(pwd)/SatisfactorySaveGames",target=/home/steam/.config/Epic/FactoryGame/Saved/SaveGames \
       --publish 15777:15777/udp --publish 15000:15000/udp --publish 7777:777/udp \
       --name satisfactory-server \
       --user=$(id -u):$(id -g) \
       [--env=GAME_VERSION=<value>] \
       [--env=MAX_PLAYERS=<value>] \
       renegademaster/satisfactory-dedicated-server[:<tag>]
   ```

### Docker-Compose

The following are instructions for running the server using Docker-Compose.

1. Download the repository:

   ```shell
   git clone https://github.com/Renegade-Master/satisfactory-dedicated-server.git \
       && cd satisfactory-dedicated-server
   ```

2. Make any configuration changes you want to in the `docker-compose.yaml` file. In
   the `services.satisfactory-server. environment` section, you can change values for
    - Game Version [`public`, `experimental`]
    - Maximum players [*Any numerical value is accepted, but more than 16 is not advised*]

3. In the `docker-compose.yaml` file, you must change the `service.satisfactory-server.user` values to match your local
   user. To find your local user and group ids, run the following command:

   ```shell
   printf "UID: %s\nGID: %s\n" $(id -u) $(id -g)
   ```

5. Run the following command:

   ```shell
   mkdir SatisfactoryDedicatedServer SatisfactorySaveGames

   docker-compose up -d
   ```

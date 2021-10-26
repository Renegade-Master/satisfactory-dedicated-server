# Satisfactory Dedicated Server

## Disclaimer

This server implementation is not official.

## Description

Dedicated Server for Satisfactory using Docker, and optionally Docker-Compose.

## Links

Resource links:
  - [Satisfactory Dedicated Server Wiki](https://satisfactory.fandom.com/wiki/Dedicated_servers)
  - [Satisfactory Homepage](https://www.satisfactorygame.com/)
  - [Steam Store Page](https://store.steampowered.com/app/526870/satisfactory)
  - [Epic Games Store Page](https://www.epicgames.com/store/en-US/p/satisfactory)

## Instructions

### Unmanaged

The following are instructions for running the server without using Docker.

1. *ToDo*

### Docker

The following are instructions for running the server using the Docker image.

1. Build the image:

    ```shell
    docker build -t satisfactory-server:1.0.0 -f docker/satisfactory-server.Dockerfile .
    ```

2. Run the container:

    ```shell
    docker run satisfactory-server:1.0.0 -p -p 15777/udp -p 15000/udp -p 7777/udp
    ```

### Docker-Compose

The following are instructions for running the server using Docker-Compose.

1. Run the following command:

    ```shell
    docker-compose up -d
    ```

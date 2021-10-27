#######################################################################
#   Author: Renegade-Master
#   Description: Base image for running a Dedicated Satisfactory server.
#######################################################################

FROM ubuntu:impish-20211015 as downloader

# Install Steam dependencies
RUN apt-get update && apt-get autoremove -y \
    && apt-get install -y \
        wget

# Set local working directory
WORKDIR /app

# Download and extract Steam
RUN wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    && tar -zxf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz

FROM ubuntu:impish-20211015 as runner

LABEL com.renegademaster.satisfactory-dedicated-server.authors="Renegade-Master"

# Set local working directory
WORKDIR /home/steam

# Install Steam dependencies, and trim image bloat
RUN apt-get update && apt-get autoremove -y \
    && apt-get install -y --no-install-recommends \
        lib32stdc++6 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the Steam installation from the previous build stage
COPY --from=downloader /app /home/steam
COPY src /home/steam/

# ake a Steam User, and change the ownership of the Steam directory
RUN useradd -m steam \
    && chown -R steam:steam /home/steam

# Switch to the Steam User
USER steam

# Run forever
ENTRYPOINT ["./run_satisfactory_server.sh"]

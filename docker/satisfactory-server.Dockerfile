#######################################################################
#   Author: Renegade-Master
#   Description: Base image for running a Dedicated Satisfactory server.
#######################################################################

FROM ubuntu:impish-20211015 as installer

LABEL com.renegademaster.satisfactory-dedicated-server.authors="Renegade-Master"

# Make a Steam User
RUN useradd -m steam

# Install Steam dependencies
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y \
    && apt-get install -y \
        wget lib32stdc++6

WORKDIR /home/steam

# Switch to the Steam User
USER steam

# Download and extract Steam
RUN wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    && tar -zxf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz

# Initialise the SteamCMD environment
RUN ./steamcmd.sh +quit

ENTRYPOINT ["tail", "-f", "/dev/null"]

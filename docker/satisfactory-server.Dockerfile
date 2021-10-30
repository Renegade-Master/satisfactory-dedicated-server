#######################################################################
#   Author: Renegade-Master
#   Description: Base image for running a Dedicated Satisfactory server.
#######################################################################

ARG UID=1000
ARG GID=1000

FROM ubuntu:impish-20211015 as downloader

# Install Steam dependencies
RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get autoremove -y \
    && apt-get install -y \
        wget libsdl2-2.0-0:i386

# Set local working directory
WORKDIR /app

# Download and extract Steam
RUN wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    && tar -zxf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz

FROM ubuntu:impish-20211015 as runner

ARG UID
ARG GID

LABEL com.renegademaster.satisfactory-dedicated-server.authors="Renegade-Master" \
    com.renegademaster.satisfactory-dedicated-server.source-repository="https://github.com/Renegade-Master/satisfactory-dedicated-server" \
    com.renegademaster.satisfactory-dedicated-server.image-repository="https://hub.docker.com/r/renegademaster/satisfactory-dedicated-server"

# Set local working directory
WORKDIR /home/steam

# Install Steam dependencies, and trim image bloat
RUN apt-get update && apt-get autoremove -y \
    && apt-get install -y --no-install-recommends \
        lib32stdc++6 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the Steam installation from the previous build stages
# Also copy only the essential libraries required for Steam to function
COPY --from=downloader /app /home/steam
COPY --from=downloader /usr/lib/i386-linux-gnu/libpthread.so.0 /usr/lib/i386-linux-gnu/libpthread.so.0
COPY --from=downloader /usr/lib/i386-linux-gnu/libthread_db.so.1 /usr/lib/i386-linux-gnu/libthread_db.so.1
COPY --from=downloader /usr/lib/i386-linux-gnu/libSDL2-2.0.so.0.14.0 /usr/lib/i386-linux-gnu/libSDL2-2.0.so.0.14.0
COPY src /home/steam/

# Link the libraries so that they can be found
# Make a Steam User, and change the ownership of the Steam directory
RUN mkdir -p /home/steam/.steam/sdk64 \
    && ln -s /usr/lib/i386-linux-gnu/libSDL2-2.0.so.0.14.0 /usr/lib/i386-linux-gnu/libSDL2-2.0.so.0 \
    && ln -s /home/steam/linux64/steamclient.so /home/steam/.steam/sdk64/steamclient.so \
    && useradd -u ${UID} -m -d /home/steam steam \
    && chown -R ${UID}:${GID} /home/steam

# Switch to the Steam User
USER ${UID}:${GID}

# Run forever
ENTRYPOINT ["./run_satisfactory_server.sh"]

#######################################################################
#   Author: Renegade-Master
#   Description: Base image for running a Dedicated Satisfactory server.
#   License: GNU General Public License v3.0 (see LICENSE)
#######################################################################

# Set the User and Group IDs
ARG USER_ID=1000
ARG GROUP_ID=1000

FROM renegademaster/steamcmd-minimal:1.0.0

# Add metadata labels
LABEL com.renegademaster.satisfactory-dedicated-server.authors="Renegade-Master" \
    com.renegademaster.satisfactory-dedicated-server.source-repository="https://github.com/Renegade-Master/satisfactory-dedicated-server" \
    com.renegademaster.satisfactory-dedicated-server.image-repository="https://hub.docker.com/r/renegademaster/satisfactory-dedicated-server"

# Copy the source files
COPY src /home/steam/

# Switch to the Steam User
USER ${USER_ID}:${GROUP_ID}

# Run the setup script
ENTRYPOINT ["/bin/bash", "/home/steam/run_satisfactory_server.sh"]

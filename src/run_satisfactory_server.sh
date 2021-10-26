#!/usr/bin/env bash
#######################################################################
#   Author: Renegade-Master
#   Description: Install, update, and start a Dedicated Satisfactory
#       instance.
#######################################################################

function start_satisfactory() {
    printf "\n### Starting Satisfactory Server...\n"

    /home/steam/SatisfactoryDedicatedServer/FactoryServer.sh
}

function update_satisfactory() {
    printf "\n### Updating Satisfactory Server...\n"

    /home/steam/steamcmd.sh +runscript /home/steam/install_satisfactory.scmd

    printf "\n### Satisfactory Server updated.\n"
}

## Main
update_satisfactory
start_satisfactory

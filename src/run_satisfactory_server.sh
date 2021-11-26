#!/usr/bin/env bash
#######################################################################
#   Author: Renegade-Master
#   Description: Install, update, and start a Dedicated Satisfactory
#       instance.
#######################################################################

# Start the Satisfactory Server
function start_satisfactory() {
    printf "\n### Starting Satisfactory Server...\n"

    /home/steam/SatisfactoryDedicatedServer/FactoryServer.sh
}

# Update the Satisfactory server
function update_satisfactory() {
    printf "\n### Updating Satisfactory Server...\n"

    $STEAM_PATH +runscript /home/steam/install_satisfactory.scmd

    printf "\n### Satisfactory Server updated.\n"
}

# Change the folder permissions for install and save directory
function update_folder_permissions() {
    printf "\n### Updating Folder Permissions...\n"

    chown -R "${USER}:${USER}" /home/steam/SatisfactoryDedicatedServer
    chown -R "${USER}:${USER}" /home/steam/.config/Epic/FactoryGame/Saved/SaveGames

    printf "\n### Folder Permissions updated.\n"
}


## Main
update_folder_permissions
update_satisfactory
start_satisfactory

#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")
OUTPUT_DIR="$DIR"/driver_openhmd

source "$DIR"/paths.sh

if [ -z "$STEAMDIR" ];
then
	echo "Error! Did not find Steam path"
	exit 1
else
	echo "Found Steam in $STEAMDIR"
fi

if [ -z "$STEAMVRDIR" ];
then
	echo "Error! Did not find SteamVR path"
	exit 1
else
	echo "Found SteamVR in $STEAMVRDIR"
fi

mkdir -p "$BACKUPDIR"

if [ ! -d "$DIR"/build ]; then
	echo "Please build in $DIR/build for this script to work"
	exit 1
fi

"$DIR/install_files_to_build.sh" || exit 1

if [ ! -f "$VRPATHREG" ]; then
	echo "Please install SteamVR such that $VRPATHREG exists"
	exit 1
fi

if [ -f "$CURRENTCONFIG" ]; then
	echo "Found config in $CURRENTCONFIG"
	echo "Backing up current config to $BACKUPDIR..."
	mv "$CURRENTCONFIG" "$BACKUPDIR"
	echo "Backed up config!"
fi

echo "Installing SteamVR-OpenHMD config..."
cp "$OHMDCONFIG" "$CURRENTCONFIG"
echo "Installed SteamVR-OpenHMD config"

echo "Registering SteamVR-OpenHMD plugin with SteamVR..."
LD_LIBRARY_PATH="$OPENVR_API_PATH:$LD_LIBRARY_PATH" "$VRPATHREG" adddriver "$OUTPUT_DIR"
echo "Registered SteamVR-OpenHMD plugin with SteamVR!"

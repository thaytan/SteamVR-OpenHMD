#!/bin/bash
TARGET_DIR=driver_openhmd

if [ -x "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

cp driver.vrdrivermanifest "$TARGET_DIR"/
cp -r resources "$TARGET_DIR"/

mkdir -p "$TARGET_DIR"/bin/{win64,win32,osx64,osx32,linux64,linux32}

rm -f "$TARGET_DIR"/bin/linux64/driver_openhmd.so && cp build/driver_openhmd.so "$TARGET_DIR"/bin/linux64 2> /dev/null && \
  echo "Installed linux plugin!" || echo "Did not find linux plugin in build/ - not installing"

rm -f "$TARGET_DIR"/bin/win64/driver_openhmd.dll && cp build/driver_openhmd.dll "$TARGET_DIR"/bin/win64 2> /dev/null && echo "Installed Windows 64-bit plugin!" || echo "Did not find Windows plugin in build/ - not installing"

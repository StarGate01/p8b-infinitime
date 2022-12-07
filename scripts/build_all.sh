#!/usr/bin/env bash

TARGET=${1:-pinetime}
TARGET=${TARGET,,}
echo "Using target $TARGET"
cd "${0%/*}"

source ./infinitime_version.sh

TARGETINT=$TARGET
if [ "$TARGETINT" != "pinetime" ]; then
    TARGETINT="p8"
fi;

./build_mcuboot.sh $TARGETINT
./build_infinitime.sh $TARGET
./build_wasp.sh $TARGETINT

echo "Copying $TARGET binaries"

rm -rf ./binaries/$TARGET
mkdir -p ./binaries/$TARGET
cp ../InfiniTime/build/src/pinetime-mcuboot-app-dfu-$INFINITIME_VERSION.zip ./binaries/$TARGET/
cp ../InfiniTime/build/src/resources/infinitime-resources-$INFINITIME_VERSION.zip ./binaries/$TARGET/
cp ../InfiniTime/build/src/resources/resources.json ./binaries/$TARGET/
cp ../wasp-os/build-$TARGETINT/reloader-factory.zip ./binaries/$TARGET/
cp ../wasp-os/build-$TARGETINT/reloader-mcuboot.zip ./binaries/$TARGET/
cp ../wasp-os/build-$TARGETINT/bootloader-daflasher.zip ./binaries/$TARGET/
cp ../wasp-os/build-$TARGETINT/bootloader.hex ./binaries/$TARGET/

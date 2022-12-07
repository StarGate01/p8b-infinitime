#!/usr/bin/env bash

TARGET=${1:-pinetime}
TARGET=${TARGET,,}
echo "Using target $TARGET"
cd "${0%/*}"

source ./infinitime_version.sh

rm -f factory_image.hex
mergehex -m ../pinetime-mcuboot-bootloader/bin/targets/$TARGET/app/@mcuboot/boot/mynewt/mynewt.elf.hex ../InfiniTime/build/src/pinetime-mcuboot-recovery-loader-image-$INFINITIME_VERSION.hex -o factory_image.hex
../wasp-os/tools/hex2c.py factory_image.hex > ../wasp-os/reloader/src/boards/$TARGET/factory_image.h

cd ../wasp-os/reloader
make -j$(nproc) BOARD=$TARGET build-$TARGET/reloader-factory.zip build-$TARGET/reloader-mcuboot.zip

cd ..
make -j$(nproc) BOARD=$TARGET reloader

rm reloader/src/boards/$TARGET/factory_image.h

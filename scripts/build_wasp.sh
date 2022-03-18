#!/bin/bash

cd "${0%/*}"

source ./infinitime_version.sh

rm -f factory_image.hex
mergehex -m ../pinetime-mcuboot-bootloader/bin/targets/nrf52_boot/app/@mcuboot/boot/mynewt/mynewt.elf.hex ../InfiniTime/build/src/pinetime-mcuboot-recovery-loader-image-$INFINITIME_VERSION.hex -o factory_image.hex
../wasp-os/tools/hex2c.py factory_image.hex > ../wasp-os/reloader/src/boards/p8/factory_image.h

cd ../wasp-os/reloader
make -j$(nproc) BOARD=p8 build-p8/reloader-factory.zip

cd ..
make -j$(nproc) BOARD=p8 reloader

rm reloader/src/boards/p8/factory_image.h

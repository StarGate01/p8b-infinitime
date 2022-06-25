#!/usr/bin/env bash

TARGET=${1:-pinetime}
TARGET=${TARGET,,}
echo "Using target $TARGET"
cd "${0%/*}"

source ./infinitime_version.sh

nrfjprog --eraseall -f nrf52
nrfjprog --program ../InfiniTime/build/src/pinetime-mcuboot-app-image-$INFINITIME_VERSION.hex --verify -f nrf52 --sectorerase

nrfjprog --program ../pinetime-mcuboot-bootloader/bin/targets/$TARGET/app/@mcuboot/boot/mynewt/mynewt.elf.hex --verify -f nrf52 --sectorerase --reset
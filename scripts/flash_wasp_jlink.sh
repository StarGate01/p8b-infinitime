#!/usr/bin/env bash

TARGET=${1:-pinetime}
TARGET=${TARGET,,}
echo "Using target $TARGET"
cd "${0%/*}"

nrfjprog --eraseall -f nrf52
nrfjprog --program ../wasp-os/build-$TARGET/bootloader.hex -f nrf52 --verify --sectorerase --reset
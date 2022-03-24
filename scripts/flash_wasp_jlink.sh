#!/bin/bash

TARGET=${1:-pinetime}
echo "Using target $TARGET"
cd "${0%/*}"

nrfjprog --eraseall -f nrf52
nrfjprog --program ../wasp-os/build-$TARGET/bootloader.hex -f nrf52 --sectorerase --reset
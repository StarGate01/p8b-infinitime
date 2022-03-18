#!/bin/bash

cd "${0%/*}"

source ./infinitime_version.sh

nrfjprog --eraseall -f nrf52
nrfjprog --program ../InfiniTime/build/src/pinetime-mcuboot-app-image-$INFINITIME_VERSION.hex -f nrf52 --sectorerase

nrfjprog --program ../pinetime-mcuboot-bootloader/bin/targets/nrf52_boot/app/@mcuboot/boot/mynewt/mynewt.elf.hex -f nrf52 --sectorerase --reset
#!/bin/bash

cd "${0%/*}"

rm -rf ../pinetime-mcuboot-bootloader/bin
rm -rf ../pinetime-mcuboot-bootloader/reloader/build-*
rm -rf ../InfiniTime/build
rm -rf ../wasp-os/build-p8
rm -rf ../wasp-os/bootloader/_build*
rm -rf ../wasp-os/reloader/build-*
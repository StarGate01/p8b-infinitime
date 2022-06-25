#!/usr/bin/env bash

TARGET=${1:-pinetime}
TARGET=${TARGET,,}
echo "Using target $TARGET"
cd "${0%/*}"

cd ../pinetime-mcuboot-bootloader

scripts/nrf52/build-boot.sh $TARGET
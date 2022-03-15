#!/bin/bash

cd "${0%/*}"

cd ../pinetime-mcuboot-bootloader

scripts/nrf52/build-boot.sh
#!/bin/bash

cd "${0%/*}"

nrfjprog --eraseall -f nrf52
nrfjprog --program ../wasp-os/build-p8/bootloader.hex -f nrf52 --sectorerase --reset
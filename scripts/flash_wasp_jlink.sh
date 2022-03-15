#!/bin/bash

nrfjprog --eraseall -f nrf52
nrfjprog --program ../wasp-os/build-p8/bootloader.hex -f nrf52 --sectorerase
nrfjprog --reset -f nrf52 
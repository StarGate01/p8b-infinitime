#!/bin/bash

cd "${0%/*}"

nrfjprog --eraseall -f nrf52
#nrfjprog --program ../InfiniTime/build/src/pinetime-app-1.8.0.hex -f nrf52 --sectorerase
nrfjprog --program ../InfiniTime/build/src/pinetime-app-1.3.0.hex -f nrf52 --sectorerase
nrfjprog --reset -f nrf52
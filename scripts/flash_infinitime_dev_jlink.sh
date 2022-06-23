#!/usr/bin/env bash

cd "${0%/*}"

source ./infinitime_version.sh

nrfjprog --eraseall -f nrf52
nrfjprog --program ../InfiniTime/build/src/pinetime-app-$INFINITIME_VERSION.hex --verify -f nrf52 --sectorerase --reset
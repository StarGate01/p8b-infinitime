#!/bin/bash

cd "${0%/*}"

source ./infinitime_version.sh

cd ../InfiniTime
bootloader/ota-dfu-python/dfu.py -z "build/src/pinetime-mcuboot-app-dfu-$INFINITIME_VERSION.zip" -a D5:DF:61:E5:8F:CE --legacy
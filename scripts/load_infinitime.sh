#!/bin/bash

cd "${0%/*}"

cd ../InfiniTime
bootloader/ota-dfu-python/dfu.py -z "build/src/pinetime-mcuboot-app-dfu-1.3.0.zip" -a D5:DF:61:E5:8F:CE --legacy
#!/bin/bash

TARGET=${1:-pinetime}
echo "Using target $TARGET"
ADDR=${1:-D5:DF:61:E5:8F:CF}
echo "Using address $ADDR"
cd "${0%/*}"

cd ../wasp-os
tools/ota-dfu/dfu.py -z "build-$TARGET/reloader-factory.zip" -a $ADDR --legacy                           

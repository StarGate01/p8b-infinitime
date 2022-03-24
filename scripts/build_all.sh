#!/bin/bash

TARGET=${1:-pinetime}
echo "Using target $TARGET"
cd "${0%/*}"

./build_mcuboot.sh $TARGET
./build_infinitime.sh $TARGET
./build_wasp.sh $TARGET
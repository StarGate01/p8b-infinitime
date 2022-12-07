#!/usr/bin/env bash

TARGET=${1:-pinetime}
TARGET=${TARGET,,}
echo "Using target $TARGET"
cd "${0%/*}"

cd ../InfiniTime
mkdir -p build
cd build

cmake -DTARGET_DEVICE=${TARGET^^} -DCMAKE_BUILD_TYPE=Release -DARM_NONE_EABI_TOOLCHAIN_PATH=$ARM_NONE_EABI_TOOLCHAIN_PATH -DNRF5_SDK_PATH=$NRF5_SDK_PATH -DBUILD_DFU=1 -DBUILD_RESOURCES=1 ..

make -j$(nproc) pinetime-app
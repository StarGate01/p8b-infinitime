#!/bin/bash

cd "${0%/*}"

cd ../InfiniTime
mkdir -p build
cd build

cmake -DWATCH_COLMI_P8=1 -DLF_CLOCK_SRC=0 -DCMAKE_BUILD_TYPE=Debug -DARM_NONE_EABI_TOOLCHAIN_PATH=/usr -DNRF5_SDK_PATH=/opt/nrf5-sdk -DUSE_JLINK=1 -DNRFJPROG=/usr/bin/nrfjprog -DBUILD_DFU=1 ..
make -j$(nproc) pinetime-app
#!/bin/bash

cd "${0%/*}"

cd ../InfiniTime
mkdir -p build
cd build

cmake -DTARGET_DEVICE=P8 -DLF_CLK=RC -DDRIVER_TOUCH=CST716 -DDRIVER_ACC=SC7A20 -DCMAKE_BUILD_TYPE=Release -DARM_NONE_EABI_TOOLCHAIN_PATH=/usr -DNRF5_SDK_PATH=/opt/nrf5-sdk -DUSE_JLINK=1 -DNRFJPROG=/usr/bin/nrfjprog -DBUILD_DFU=1 ..
make -j$(nproc) pinetime-mcuboot-app pinetime-mcuboot-recovery-loader
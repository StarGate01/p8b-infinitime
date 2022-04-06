#!/bin/bash

TARGET=${1:-pinetime}
echo "Using target $TARGET"
cd "${0%/*}"

cd ../InfiniTime
mkdir -p build
cd build

COMMON_OPTIONS="-DCMAKE_BUILD_TYPE=Release -DARM_NONE_EABI_TOOLCHAIN_PATH=/usr -DNRF5_SDK_PATH=/opt/nrf5-sdk -DUSE_JLINK=1 -DNRFJPROG=/usr/bin/nrfjprog -DBUILD_DFU=1"
if [ "$TARGET" = "pinetime" ]; then
    cmake -DDRIVER_TOUCH=DYNAMIC -DTARGET_DEVICE=PINETIME -DLF_CLK=XTAL -DDRIVER_ACC=BMA421 $COMMON_OPTIONS ..
elif [ "$TARGET" = "p8" ] || [ "$TARGET" = "p8b" ]; then
    cmake -DDRIVER_TOUCH=REPORT -DTARGET_DEVICE=P8 -DLF_CLK=RC -DDRIVER_ACC=SC7A20 $COMMON_OPTIONS ..
elif [ "$TARGET" = "p8a" ]; then
    cmake -DDRIVER_TOUCH=GESTURE -DTARGET_DEVICE=P8 -DLF_CLK=XTAL -DDRIVER_ACC=BMA421 $COMMON_OPTIONS ..
fi

make -j$(nproc) pinetime-app
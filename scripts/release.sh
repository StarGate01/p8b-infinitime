#!/usr/bin/env bash

cd "${0%/*}"

source ./infinitime_version.sh

rm -rf binaries

./clean.sh
./build_all.sh PINETIME
./clean.sh
./build_all.sh MOY_TFK5
./clean.sh
./build_all.sh MOY_TIN5
./clean.sh
./build_all.sh MOY_TON5
./clean.sh
./build_all.sh MOY_UNK
./clean.sh

for bld in binaries/*; do
    zip -j $bld.zip $bld/*
done

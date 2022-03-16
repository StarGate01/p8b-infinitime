#!/bin/bash

cd "${0%/*}"

cd ../wasp-os
git -c submodule."micropython".update=none submodule update --init --recursive
pip3 install --user -r wasp/requirements.txt

cd ../InfiniTime
git submodule update --init --recursive

cd ../pinetime-mcuboot-bootloader
git submodule update --init --recursive
newt upgrade
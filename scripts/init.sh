#!/bin/bash

cd "${0%/*}"

cd ..

git submodule update --init --recursive

cd pinetime-mcuboot-bootloader
newt upgrade

cd ../wasp-os
pip3 install --user -r wasp/requirements.txt
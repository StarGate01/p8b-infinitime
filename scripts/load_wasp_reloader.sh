#!/bin/bash

cd ../wasp-os
tools/ota-dfu/dfu.py -z "build-p8/reloader-factory.zip" -a D5:DF:61:E5:8F:CF --legacy                           

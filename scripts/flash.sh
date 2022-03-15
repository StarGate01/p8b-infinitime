#!/bin/bash

# nrfjprog --eraseall -f nrf52

# nrfjprog --program ../wasp-os/build-p8/bootloader.hex -f nrf52 --sectorerase

# srec_cat ../DaFlasherFiles/FitBootloaderDFU2.0.1/sd_bl.bin -binary -offset 0x00000000 -o dfb.hex -intel --line-length=44
# nrfjprog --program dfb.hex -f nrf52 --sectorerase

# nrfjprog --program ../InfiniTime/build/src/pinetime-recovery-loader-1.3.0.hex -f nrf52 --sectorerase

# rm -f sd_bl.hex
# srec_cat sd_bl.bin -binary -offset 0x00000000 -o sd_bl.hex -intel --line-length=44
# nrfjprog --program sd_bl.hex -f nrf52 --sectorerase


# nrfjprog --program ../pinetime-mcuboot-bootloader/bin/targets/nrf52_boot/app/@mcuboot/boot/mynewt/mynewt.elf.hex -f nrf52 --sectorerase

# nrfjprog --program ../InfiniTime/build/src/pinetime-mcuboot-app-image-1.3.0.hex -f nrf52 --sectorerase

# nrfjprog --program ../InfiniTime/build/src/pinetime-app-1.3.0.hex -f nrf52 --sectorerase

# rm -f image.bin
# ../InfiniTime/tools/mcuboot/imgtool.py create --align 4 --version 1.0.0 --header-size 32 --slot-size 475136 --pad-header ../InfiniTime/build/src/pinetime-mcuboot-recovery-loader-image-1.3.0.bin image.bin
# rm -f image.hex
# srec_cat ../InfiniTime/build/src/pinetime-mcuboot-recovery-loader-image-1.3.0.hex.bin -binary -offset 0x00008000 -o image.hex -intel --line-length=44
# nrfjprog --program image.hex -f nrf52 --sectorerase

# nrfjprog --reset -f nrf52 
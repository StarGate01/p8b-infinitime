# InfiniTime on P8b

This repository contains some slightly adjusted versions of the Infinitime application, bootloader and reloader (based on wasp-os), to run on the P8b smartwatch.

## Download Binaries

If you don't want to compile the firmware yourself, you can download binaries on the [release page](https://github.com/StarGate01/p8b-infinitime/releases).

## Development Setup

Requirements for compilation:

- Linux
- GCC, Build-essentials, Git, Bash, Wget, Unzip
- ARM Cortex toolchain
- NRF52 tools
- Apache Mynewt Newt
- CMake
- Python3 + Pip3

Run `scripts/init.sh` to set up the repositories. This clones all the submodules, and downloads the newt and python packages. This might take a while, there are a lot of submodules.

## Compiling

Use the scripts in `scripts/`. First compile InfiniTime (`build_infinitime.sh`) and mcuboot  (`build_mcuboot.sh`), and then compile wasp-os (`build_wasp.sh`). The Wasp reloader factory package will package the builds of mcuboot and the Infinitime minimal recovery loader.

## OTA Stock Upgrade Path:

**Do this at your own risk**

Step 1

- State: Stock P8b (Stock)
- Process: DFU update using DaFlasher
- Payload: `DaFlasherFiles/DaFitBootloader23Hacked.bin`

Step 2

- State: Hacked Bootloader (Three colorful quared)
- Process: DFU update using DaFlasher or NrfConnect
- Payload: `DaFlasherFiles/FitBootloaderDFU2.0.1.zip`

Step 3

- State: Fit Bootloader (One square)
- Process: DFU update using DaFlasher or NrfConnect
- Payload: `wasp-os/build-p8/bootloader-daflasher.zip` (P8b variant)

Step 4

- State: Wasp-OS Bootloader (Wasp image)
- Process: DFU update using dfu.py (`scripts/load_wasp_reloader.sh`) or NrfConnect (or DaFlasher?)
- Payload: `wasp-os/build-p8/reloader-factory.zip` (P8b variant w/ mcuboot & Infinitime recovery loader)

Step 5

- State: Wasp-OS Reloader (Small pinecone)
- Process: Wait for internal flash overwrite (pinecone turns red), then reboot by pressing button long, or it reboots automatically

Step 6

- State: MCUBoot Bootloader (Big pinecone V1.0.0)
- Process: Wait for bootloader to boot recovery installer

Step 7

- State: Infinitime recovery installer (Triangle with progress bar)
- Process: Wait for external flash to be written (progress bar). Reboots automatically

Step 8

- State: MCUBoot Bootloader
- Process: Press button until big pinecone is red. Bootloader then installs recovery image. Wait for reboot.

Step 9

- State: Infinitime recovery (Triangle without progress bar)
- Process: DFU update using NRFConnect or GadgetBridge (or DaFlasher?)
- Payload: `InfiniTime/build/src/pinetime-mcuboot-app-dfu-1.3.0.zip`

Step 10

- State: MCUBoot Bootloader
- Process: Press button until pinecone turns blue, this loads the main app.

Step 11

- State: Infinitime Application (Watchface)
- Process: Verify firmware works, and then confirm firmware valid in settings. (Important, otherwise bootloader reverts to recovery)

## SWD Flash Path:

**Do this at your own risk**

For OTA

- State: Broken or empty
- Process: Open watch, flash using SWD, eg. J-Link, then continue from wasp-bootloader
- Payload: `wasp-os/build-p8/bootloader.hex` (P8b variant)

For Development

- State: Development on InfiniTime
- Process: Open watch, flash using SWD, eg. J-Link
- Payload: `InfiniTime/build/src/pinetime-app-1.3.0.hex` (P8b variant without bootloader)

## TODO

- Verify OTA process on sealed watch
- Power analysis (Synth LF clock?)
- Verify acceleration sensor
- ~Update mcuboot to latest~ done
- Update Infinitime to latest (requires touch driver improvements)


## Third-party modules & Thanks to

- `pinetime-mcuboot-bootloader/p8b` at [StarGate01/pinetime-mcuboot-bootloader](https://github.com/StarGate01/pinetime-mcuboot-bootloader.git), fork of [InfiniTimeOrg/pinetime-mcuboot-bootloader](https://github.com/InfiniTimeOrg/pinetime-mcuboot-bootloader)

- `InfiniTime/p8b` at [StarGate01/InfiniTime](https://github.com/StarGate01/InfiniTime), fork of [ildar/InfiniTime](https://github.com/ildar/InfiniTime)/p8, fork of [InfiniTimeOrg/InfiniTime](https://github.com/InfiniTimeOrg/InfiniTime)

- `wasp-os` at [daniel-thompson/wasp-os](https://github.com/daniel-thompson/wasp-os)

- `DaFlasherFiles` at [atc1441/DaFlasherFiles.git](https://github.com/atc1441/DaFlasherFiles.git)
# InfiniTime on P8

This repository contains some slightly adjusted versions of the Infinitime application, bootloader and reloader (based on wasp-os), to run on the P8a and P8b (and of course, the PineTime as well) smartwatch.

### P8a vs P8b

The (at least the one I have) P8b uses a different SPI flash chip. The bootloader is configured to accept either chip. 

In addition, the touch driver is a bit different. The P8 touch driver cannot wake up from sleep mode, so instead the accelerometer is used to detect taps and double taps to wake up. The touch driver configuration set in the factory may also vary. A compile time variable is provided. See the file `HardwareVariants.md` for more info.

# High-Resolution BLE Accelerometer

This firmware fork is able to broadcast the 12-bit accelerometer sensor data using a sampling rate of 200 Hz instead of 10 Hz. A companion Android app to read these values in real-time can be found here: https://github.com/StarGate01/PineTimeAcc .

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

Run `scripts/init.sh` to set up the repositories, do not clone this repo with all recursive submodules. This loads all the required submodules, and downloads the newt and python packages.

## Compiling

Use the scripts in `scripts/`, run `build_all.sh p8` to build all the firmware for the P8 watch. The Wasp reloader factory package will package the builds of mcuboot and the Infinitime minimal recovery loader.

All scripts accept either `pinetime`, `p8`, `p8a` or `p8b` as the first argument (Default: `pinetime`). This argument configures the target hardware platform.

You can change the compile time parameters in `build_infinitime.sh` if your smartwatch has a different hardware configuration.

See the file `HardwareVariants.md` for detailed configuration options for different watches.

## OTA Stock Upgrade Path:

Note: NRF connect sometimes seems to overload the connection, if it fails use another tool listed (or look at https://wiki.pine64.org/wiki/PineTime#Companion_Apps)

In general, sometimes the Bluetooth connection crashes, maybe due to interference. Just try again.

**Do this at your own risk**

Step 1

- State: Stock P8b (Stock)
- Process: DFU update using DaFlasher
- Payload: `DaFlasherFiles/DaFitBootloader23Hacked.bin`

Step 2

- State: Hacked Bootloader (Three colorful squares)
- Process: DFU update using DaFlasher or NrfConnect
- Payload: `DaFlasherFiles/FitBootloaderDFU2.0.1.zip`

Step 3

- State: Fit Bootloader (One square)
- Process: DFU update using DaFlasher or NrfConnect
- Payload: `wasp-os/build-p8/bootloader-daflasher.zip` (P8b variant)

Step 4

- State: Wasp-OS Bootloader (Wasp image)
- Process: DFU update using dfu.py (`scripts/load_wasp_reloader.sh p8`) or NrfConnect (or DaFlasher?)
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
- Process: DFU update using dfu.py (`scripts/load_infinitime.sh`) or NRFConnect or GadgetBridge (or DaFlasher?)
- Payload: `InfiniTime/build/src/pinetime-mcuboot-app-dfu-1.8.0.zip`

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
- Payload: `InfiniTime/build/src/pinetime-app-1.8.0.hex` (P8b variant without bootloader)

## TODO

- ~Verify OTA process on sealed watch~ done
- ~Verify drivers on genuine Pinetime~ done
- ~Use LFRC clock instead of SYNT on variants without external LF crystal~ done
- ~Verify acceleration sensor~ done
- ~Update mcuboot to latest~ done
- ~Fix wake from sleep~ done
- ~Update Infinitime to latest (requires touch driver improvements)~ done
- ~Test and adjust to P8a watch~ done
- ~Implement tap to wake on P8a~ workaround

## LFCLK and missing LF crystals

The P8b watch comes without an external low frequency crystal. This is a problem, because precise timing is required for Bluetooth connections. However, the NRF52 can be configured to use its internal RC clock to generate the low frequency clock.

The wasp-os bootloader as well as the mcuboot bootloader are configured to use this LFRC source. Wasp-os uses the Nordic softdevice, which takes care of properly configuring and calibrating the LF RC source. Mcuboot does not perform any calibration, however it does not require Bluetooth at all.

Usage of the LFRC source in InfiniTime and its Nimble stack is now implemented with proper calibration in my p8b fork.

## Third-party modules & Thanks to

- `pinetime-mcuboot-bootloader/p8b` at [StarGate01/pinetime-mcuboot-bootloader](https://github.com/StarGate01/pinetime-mcuboot-bootloader.git), fork of [InfiniTimeOrg/pinetime-mcuboot-bootloader](https://github.com/InfiniTimeOrg/pinetime-mcuboot-bootloader)

- `InfiniTime/p8b` at [StarGate01/InfiniTime](https://github.com/StarGate01/InfiniTime), fork of [ildar/InfiniTime](https://github.com/ildar/InfiniTime)/p8, fork of [InfiniTimeOrg/InfiniTime](https://github.com/InfiniTimeOrg/InfiniTime)

- `wasp-os` at [daniel-thompson/wasp-os](https://github.com/daniel-thompson/wasp-os)

- `DaFlasherFiles` at [atc1441/DaFlasherFiles.git](https://github.com/atc1441/DaFlasherFiles.git)
# Power Analysis

## Methodology

The probe was configured as follows:
 - Model: Nordic Power Profiler Kit II
 - Sample time: `60 s`
 - Sample resolution: `100000 samples/s`
 - Precision: `100 nA`
 - Output voltage: `5 V`

The devices under test (DUT) were configured as follows:
 - Battery disconnected
 - USB charging pads connected to probe power delivery
 - Firmware built in release mode
 - No bootloader
 - Screen off
 - Hard power cycle after programming
 - Waited for BLE advertising windows to end

Measurements were taken for the following DUTs:
 - P8B MOY-TON5 watch
 - Pinetime watch

Measurements were taken in the following DUT modes (product):
 - Nimble patches enabled (`MYNEWT_VAL_BLE_LL_RFMGMT_ENABLE_TIME=1500`)
 - Nimble patches disabled (No such variable set)
 - Bluetooth connected to Smartphone
 - Bluetooth disconnected
 - High-frequency motion date via BLE enabled
 - High-frequency motion date via BLE disabled (Pinetime only)

Firmware versions:
 - For P8B: Built from my P8 fork at `p8b` with HF motion data via BLE enabled.
 - For Pinetime: First run: Built from upstream `develop` merged with my PR `nimble-fixes`. HF motion data via BLE disabled. Second run: Built from my P8 fork at `p8b` with HF motion data via BLE enabled.

On the P8B, all tests had HFBLE support enables. On the Pinetime, both modes were tested.

## Results

| Device | Patch   | HFBLE   | Connect | Avg [mA] | Max [mA] | Filename                      |
| ------ | ------- | ------- | ------- | -------- | -------- | ----------------------------- |
| P8B    | **Yes** | **Yes** | No      | `1.59`   | `56.28`  | `p8-hfble-patch`              |
| P8B    | **Yes** | **Yes** | **Yes** | `2.01`   | `61.21`  | `p8-hfble-patch-connection`   |
| P8B    | No      | **Yes** | No      | `1.79`   | `54.88`  | `p8-hfble`                    |
| P8B    | No      | **Yes** | **Yes** | `2.15`   | `52.85`  | `p8-hfble-connection`         |
| PINE   | **Yes** | No      | No      | `1.16`   | `33.32`  | `pine-patch`                  |
| PINE   | **Yes** | No      | **Yes** | `1.25`   | `32.80`  | `pine-patch-connection`       |
| PINE   | No      | No      | No      | `1.37`   | `32.90`  | `pine`                        |
| PINE   | No      | No      | **Yes** | `1.44`   | `31.40`  | `pine-connection`             |
| PINE   | **Yes** | **Yes** | No      | `1.56`   | `32.80`  | `pine-hfble-patch`            |
| PINE   | **Yes** | **Yes** | **Yes** | `1.84`   | `32.02`  | `pine-hfble-patch-connection` |
| PINE   | No      | **Yes** | No      | `1.77`   | `33.27`  | `pine-hfble`                  |
| PINE   | No      | **Yes** | **Yes** | `2.02`   | `31.24`  | `pine-hfble-connection`       |

Result logfiles in `ppk/` can be viewed using the *nRF Connect for Desktop* application.

## Interpretation

The high current values for the maximum current come from very short current spikes, usually when transmitting a packet via Bluetooth.

The **Nimble patches** lead to a mean average current reduction of `-0.188 mA` across all tests, which is `-12.7%` on average.

The **HF motion via BLE** functionality leads to a mean average current increase of `+0.492 mA` across all tests, which is `+37.8%` on average. This indicates that the accelerometer uses quite a bit of power.

Since the DUTs were powered via the USB pads, the USB voltage regulator might have added noise and an offset. To eliminate these factors, the NRF power pins would have to be tapped, or the measurements performed on a NRF-DK.

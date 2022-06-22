# P8 Hardware Variants

## Pinetime

- Seen as: `Pinetime`
- Pinmap: Pinetime (`TARGET_DEVICE=PINETIME`)
- Acceleration sensor: BMA421 (`DRIVER_ACC=BMA421`)
- LF clock: XTAL (`LF_CLK=XTAL`)
- Touch sensor: dynamic (`DRIVER_TOUCH=DYNAMIC`)
    - Chip marking: `CST816S`
    - Reports as `B4-0.1`
    - Configurable mode of operation
    - Sometimes fails to reset on pin signal
    - Behavior: Gesture event during gesture, touch events during gesture
- Flash: XT25F32B


## P8a variant 1

- Seen as: `MOY-TFK5`
- Pinmap: P8 (`TARGET_DEVICE=P8`)
- Acceleration sensor: BMA421 (`DRIVER_ACC=BMA421`)
- LF clock: XTAL (`LF_CLK=XTAL`)
- Touch sensor: fused gesture (`DRIVER_TOUCH=GESTURE`)
    - Chip marking: `CST716`
    - Reports as `B4-0.2`
    - Fused mode of operation in gesture mode
    - Behavior: Gesture event after gesture only
- Flash: XM25QH32B


## P8a variant 2

- Seen as: `MOY-TIN5`
- Pinmap: P8 (`TARGET_DEVICE=P8`)
- Acceleration sensor: SC7A20 (`DRIVER_ACC=SC7A20`)
- LF clock: XTAL (`LF_CLK=XTAL`)
- Touch sensor: fused gesture (`DRIVER_TOUCH=GESTURE`)
    - Chip marking: `CST716`
    - Reports as `B4-0.2`
    - Fused mode of operation in gesture mode
    - Behavior: Gesture event after gesture only
- Flash: XM25QH32B


## P8b

- Seen as: `MOY-TON5`
- Pinmap: P8 (`TARGET_DEVICE=P8`)
- Acceleration sensor: SC7A20 (`DRIVER_ACC=SC7A20`)
- LF clock: RC (`LF_CLK=RC`)
- Touch sensor: fused reporting (`DRIVER_TOUCH=REPORT`)
    - Chip marking: `CST816`
    - Reports as `20-6c.5`, `20-6c.7`
    - Fused mode of operation in reporting mode
    - Resets on pin signal
    - Behavior: Gesture event after gesture, touch events during gesture
- Flash: P25Q32H

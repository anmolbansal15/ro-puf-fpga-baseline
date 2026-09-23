# Parameterized gated Ring Oscillator baseline

First behavioral-simulation milestone for an FPGA Ring Oscillator Physical
Unclonable Function (RO-PUF) project.

## Current state

- Parameterized gated RO, with an odd number of stages.
- N=7 behavioral simulation testbench.
- Expected N=7 period: approximately 14 ns for the provided 1 ns simulated
  delay per stage, or approximately 71.4 MHz.

## Architecture

`N` counts all inversion stages in the feedback loop: one NAND gate plus
`N-1` inverters. Therefore, `N` must be odd.

```text
                   +----------------------------------+
                   |                                  |
ena --> NAND --> INV --> INV --> ... --> INV --> ro_out+
```

When `ena=0`, the NAND disables the loop. When `ena=1`, transitions circulate
through the odd-inversion loop.

## Files

- `rtl/ro_puf.v`: parameterized gated RO.
- `tb/ro_puf_tb.v`: N=7 behavioral testbench.

## Important limitation

`#(STAGE_DELAY)` is for behavioral simulation only. FPGA synthesis ignores
these delays and may optimize an intentional combinational feedback loop.
The next implementation milestone must use tool-specific preservation
constraints and validate that the RO structure is retained.

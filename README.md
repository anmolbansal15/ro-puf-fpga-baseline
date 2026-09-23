# Parameterized gated Ring Oscillator baseline

First behavioral-simulation milestone for an FPGA Ring Oscillator Physical
Unclonable Function (RO-PUF) project.

## Current state

- Parameterized gated RO, with an odd number of stages.
- N=7 behavioral simulation testbench.
- Vivado synthesis tested for FPGA implementation.
- `KEEP` and `DONT_TOUCH` attributes added to preserve the RO stage chain.
- Complete N=7 RO structure is retained in the Vivado synthesized schematic.
- Target FPGA: XC7S50CSGA324-1 (Spartan-7).

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

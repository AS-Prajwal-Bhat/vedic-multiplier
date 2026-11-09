# 4-bit Vedic Multiplier — Vivado Project

## 1. Project overview

This project implements a 4-bit × 4-bit unsigned combinational multiplier in
Verilog HDL using the Urdhva Tiryagbhyam (vertical and crosswise) approach.

The 4×4 architecture is hierarchical and instantiates four 2×2 Vedic
multiplier blocks. The output is an 8-bit product.

## 2. Directory structure

```text
Vedic_Multiplier_Vivado/
├── rtl/
│   ├── vedic2x2.v
│   └── vedic4x4.v
├── sim/
│   ├── vedic2x2_tb.v
│   └── vedic4x4_tb.v
├── scripts/
│   ├── create_project.tcl
│   ├── run_sim.tcl
│   └── synth_report.tcl
├── constraints/
│   └── README_XDC.txt
└── README.md
```

## 3. RTL design

Split each input into two 2-bit portions:

- `a = a_high × 4 + a_low`
- `b = b_high × 4 + b_low`

Four 2×2 blocks generate:

- `c0 = a_low × b_low`
- `c1 = a_high × b_low`
- `c2 = a_low × b_high`
- `c3 = a_high × b_high`

The full product is:

`P = c0 + ((c1 + c2) << 2) + (c3 << 4)`

The RTL keeps the intermediate carry bits while combining these partial
products. All arithmetic is unsigned.

## 4. Functional simulation

### GUI method

1. Open Vivado.
2. Select **Create Project** and choose **RTL Project**.
3. Add `rtl/vedic2x2.v` and `rtl/vedic4x4.v` under Design Sources.
4. Add `sim/vedic4x4_tb.v` under Simulation Sources.
5. Set `vedic4x4` as the design top and `vedic4x4_tb` as the simulation top.
6. Select **Run Simulation → Run Behavioral Simulation**.
7. Run the simulation to completion and inspect the Tcl console.

The testbench exhaustively checks all 256 possible input pairs. A successful
run prints:

`RESULT: PASS - all 256 input combinations passed.`

### Tcl project creation

From the project root, run:

```bash
vivado -mode batch -source scripts/create_project.tcl
```

Edit the `PART` variable in that script first. The included part number is
only an example for a Basys 3 board.

### Simulation using the Vivado GUI

The most reliable method is to use the GUI flow above. The `run_sim.tcl`
script is an optional Tcl starting point; depending on Vivado release and
simulation setup, the GUI flow may be preferable.

## 5. Synthesis and reports

In Vivado, set `vedic4x4` as the synthesis top and run **Run Synthesis**.
Alternatively, after creating/opening the project, source:

```tcl
source scripts/synth_report.tcl
```

The script writes utilization, timing-summary, power, checkpoint, and
synthesized-netlist outputs into `reports/`.

This RTL is combinational and has no clock port. A clock constraint is not
appropriate. For meaningful board-level timing, assign real I/O pins and
apply interface-specific input/output delay constraints. For meaningful
power estimation, provide realistic switching activity and device settings.

## 6. Example vectors

| A (decimal) | B (decimal) | Product (decimal) | Product (binary) |
|---:|---:|---:|:---|
| 3 | 4 | 12 | 00001100 |
| 5 | 5 | 25 | 00011001 |
| 7 | 7 | 49 | 00110001 |
| 10 | 6 | 60 | 00111100 |
| 12 | 13 | 156 | 10011100 |
| 15 | 15 | 225 | 11100001 |

## 7. Important report corrections

- Vivado is an FPGA synthesis/implementation environment. Cadence Genus
  reports cannot be reproduced by Vivado and should not be presented as
  Vivado results.
- Area and power values depend on the exact FPGA part, synthesis settings,
  constraints, and switching activity. Do not reuse the example report values
  as results for this RTL.
- The multiplier is unsigned. Signed multiplication would require a different
  design or explicit signed handling.
- A 4-bit multiplier has 16×16 = 256 possible input combinations; the
  exhaustive testbench checks all of them.

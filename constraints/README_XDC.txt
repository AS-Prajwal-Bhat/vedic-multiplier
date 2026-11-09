XDC NOTES

The 4x4 Vedic multiplier RTL is purely combinational and has no clock input.
Therefore, do not add a create_clock constraint to this RTL.

For actual FPGA board implementation:
1. Identify the exact FPGA part and board.
2. Assign the eight input pins (a[3:0], b[3:0]) and eight output pins (p[7:0])
   using the board's official master XDC.
3. Set IOSTANDARD values appropriate for the board's I/O bank voltage.
4. Add input/output delay constraints only when the external timing interface
   is known.

Do not use guessed PACKAGE_PIN values. Incorrect pin assignments can prevent
implementation or cause electrical conflicts.

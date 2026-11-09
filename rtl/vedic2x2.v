// 2x2 Vedic multiplier using Urdhva Tiryagbhyam (vertical and crosswise).
// Combinational RTL; synthesizable in Xilinx Vivado.

`timescale 1ns/1ps

module vedic2x2 (
    input  wire [1:0] a,
    input  wire [1:0] b,
    output wire [3:0] p
);

    wire cross0;
    wire cross1;
    wire carry1;
    wire msb_partial;

    assign p[0] = a[0] & b[0];

    assign cross0 = a[1] & b[0];
    assign cross1 = a[0] & b[1];

    assign p[1] = cross0 ^ cross1;
    assign carry1 = cross0 & cross1;

    assign msb_partial = a[1] & b[1];
    assign p[2] = msb_partial ^ carry1;
    assign p[3] = msb_partial & carry1;

endmodule

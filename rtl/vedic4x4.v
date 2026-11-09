// Hierarchical 4x4 Vedic multiplier.
// Four 2x2 blocks generate:
// c0 = a_low  * b_low
// c1 = a_high * b_low
// c2 = a_low  * b_high
// c3 = a_high * b_high
//
// Product = c0 + ((c1 + c2) << 2) + (c3 << 4)
//
// The staged additions below retain all carry bits.

`timescale 1ns/1ps

module vedic4x4 (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [7:0] p
);

    wire [3:0] c0;
    wire [3:0] c1;
    wire [3:0] c2;
    wire [3:0] c3;

    wire [5:0] middle_sum;
    wire [5:0] upper_sum;

    vedic2x2 vm1 (
        .a(a[1:0]),
        .b(b[1:0]),
        .p(c0)
    );

    vedic2x2 vm2 (
        .a(a[3:2]),
        .b(b[1:0]),
        .p(c1)
    );

    vedic2x2 vm3 (
        .a(a[1:0]),
        .b(b[3:2]),
        .p(c2)
    );

    vedic2x2 vm4 (
        .a(a[3:2]),
        .b(b[3:2]),
        .p(c3)
    );

    // Lowest two product bits come directly from c0.
    assign p[1:0] = c0[1:0];

    // Add cross products and the upper two bits of c0.
    // middle_sum = c1 + c2 + c0[3:2], maximum value = 21.
    assign middle_sum =
        {2'b00, c1} +
        {2'b00, c2} +
        {4'b0000, c0[3:2]};

    // The lower two bits of middle_sum become product bits [3:2].
    assign p[3:2] = middle_sum[1:0];

    // Add the high-high product and the carry from the middle stage.
    // upper_sum maximum value = 9 + 5 = 14.
    assign upper_sum =
        {2'b00, c3} +
        {2'b00, middle_sum[5:2]};

    assign p[7:4] = upper_sum[3:0];

endmodule

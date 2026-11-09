`timescale 1ns/1ps

module vedic4x4_tb;

    reg  [3:0] a;
    reg  [3:0] b;
    wire [7:0] p;

    integer i;
    integer j;
    integer errors;
    integer tests;
    reg [7:0] expected;

    vedic4x4 dut (
        .a(a),
        .b(b),
        .p(p)
    );

    initial begin
        a      = 4'd0;
        b      = 4'd0;
        errors = 0;
        tests  = 0;

        $display("==============================================");
        $display(" Exhaustive verification: 4-bit Vedic Multiplier");
        $display("==============================================");

        // Test every possible pair: 16 x 16 = 256 vectors.
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;
                expected = i * j;
                #10;
                tests = tests + 1;

                if (p !== expected) begin
                    errors = errors + 1;
                    $display("FAIL A=%0d (0x%h), B=%0d (0x%h): P=%0d (0x%h), expected=%0d (0x%h)",
                             a, a, b, b, p, p, expected, expected);
                end
            end
        end

        $display("----------------------------------------------");
        $display("Vectors tested : %0d", tests);
        $display("Errors         : %0d", errors);

        if (errors == 0)
            $display("RESULT: PASS - all 256 input combinations passed.");
        else
            $display("RESULT: FAIL - inspect the mismatches above.");

        $display("==============================================");
        $finish;
    end

endmodule

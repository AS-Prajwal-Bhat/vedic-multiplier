`timescale 1ns/1ps

module vedic2x2_tb;

    reg  [1:0] a;
    reg  [1:0] b;
    wire [3:0] p;
    integer i, j, errors;
    reg [3:0] expected;

    vedic2x2 dut (.a(a), .b(b), .p(p));

    initial begin
        errors = 0;
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                a = i;
                b = j;
                expected = i * j;
                #10;
                if (p !== expected) begin
                    errors = errors + 1;
                    $display("FAIL: a=%0d b=%0d p=%0d expected=%0d",
                             a, b, p, expected);
                end
            end
        end

        if (errors == 0)
            $display("2x2 TEST PASS: all 16 combinations passed.");
        else
            $display("2x2 TEST FAIL: %0d errors.", errors);

        $finish;
    end

endmodule

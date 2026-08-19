`timescale 1ns/1ps
module tb_adder_subtractor4;
    reg  [3:0] A, B;
    reg         ctrl;
    wire [3:0] S;
    wire        cout, overflow;

    adder_subtractor4 dut (.A(A), .B(B), .ctrl(ctrl), .S(S), .cout(cout), .overflow(overflow));

    initial begin
        $display("ctrl  A     B     ->  S     cout  (decimal check)");

        ctrl = 0; A = 4'b0011; B = 4'b0101; #1; // 3 + 5 = 8
        $display(" %b   %b  %b  ->  %b   %b    (%0d + %0d = %0d)", ctrl, A, B, S, cout, A, B, S);

        ctrl = 0; A = 4'b0110; B = 4'b0111; #1; // 6 + 7 = 13
        $display(" %b   %b  %b  ->  %b   %b    (%0d + %0d = %0d)", ctrl, A, B, S, cout, A, B, S);

        ctrl = 1; A = 4'b0111; B = 4'b0011; #1; // 7 - 3 = 4
        $display(" %b   %b  %b  ->  %b   %b    (%0d - %0d = %0d)", ctrl, A, B, S, cout, A, B, S);

        ctrl = 1; A = 4'b0011; B = 4'b0111; #1; // 3 - 7 = -4 (2's complement -> 1100)
        $display(" %b   %b  %b  ->  %b   %b    (%0d - %0d = %0d, borrow=%b)", ctrl, A, B, S, !cout, A, B, S, !cout);

        $finish;
    end
endmodule

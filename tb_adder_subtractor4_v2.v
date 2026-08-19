`timescale 1ns/1ps
module tb_adder_subtractor4;
    reg  [3:0] A, B;
    reg         ctrl;
    wire [3:0] S;
    wire        cout, overflow;
    wire        borrow;

    adder_subtractor4 dut (.A(A), .B(B), .ctrl(ctrl), .S(S), .cout(cout), .overflow(overflow));

    assign borrow = ~cout;

    initial begin
        $display("ctrl  A     B     ->  S     cout");

        ctrl = 0; A = 4'b0011; B = 4'b0101; #1;
        $display(" %b   %b  %b  ->  %b   %b", ctrl, A, B, S, cout);
        $display("     (%0d + %0d = %0d)", A, B, S);

        ctrl = 0; A = 4'b0110; B = 4'b0111; #1;
        $display(" %b   %b  %b  ->  %b   %b", ctrl, A, B, S, cout);
        $display("     (%0d + %0d = %0d)", A, B, S);

        ctrl = 1; A = 4'b0111; B = 4'b0011; #1;
        $display(" %b   %b  %b  ->  %b   %b", ctrl, A, B, S, cout);
        $display("     (%0d - %0d = %0d)", A, B, S);

        ctrl = 1; A = 4'b0011; B = 4'b0111; #1;
        $display(" %b   %b  %b  ->  %b   %b", ctrl, A, B, S, cout);
        $display("     (%0d - %0d = %0d, borrow=%b)", A, B, S, borrow);

        $finish;
    end
endmodule

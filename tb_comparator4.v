`timescale 1ns/1ps
module tb_comparator4;
    reg  [3:0] A, B;
    wire        E, G, L;

    comparator4 dut (.A(A), .B(B), .E(E), .G(G), .L(L));

    initial begin
        $display(" A     B     E G L");

        A = 4'd5;  B = 4'd5;  #1; $display("%b  %b   %b %b %b  (5 vs 5)",  A, B, E, G, L);
        A = 4'd9;  B = 4'd3;  #1; $display("%b  %b   %b %b %b  (9 vs 3)",  A, B, E, G, L);
        A = 4'd2;  B = 4'd11; #1; $display("%b  %b   %b %b %b  (2 vs 11)", A, B, E, G, L);
        A = 4'd15; B = 4'd0;  #1; $display("%b  %b   %b %b %b  (15 vs 0)", A, B, E, G, L);
        A = 4'd0;  B = 4'd15; #1; $display("%b  %b   %b %b %b  (0 vs 15)", A, B, E, G, L);

        $finish;
    end
endmodule

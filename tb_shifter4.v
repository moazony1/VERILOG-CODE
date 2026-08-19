`timescale 1ns/1ps
module tb_shifter4;
    reg  [3:0] Bit;
    reg         SHIFT;
    wire [3:0] Y;

    shifter4 dut (.Bit(Bit), .SHIFT(SHIFT), .Y(Y));

    initial begin
        $display("SHIFT  Bit3210  ->  Y3210");
        Bit = 4'b1011; SHIFT = 0; #1;
        $display("  %b     %b     ->   %b   (pass-through)", SHIFT, Bit, Y);

        Bit = 4'b1011; SHIFT = 1; #1;
        $display("  %b     %b     ->   %b   (shift right by 1)", SHIFT, Bit, Y);

        Bit = 4'b0001; SHIFT = 1; #1;
        $display("  %b     %b     ->   %b   (shift right by 1)", SHIFT, Bit, Y);

        $finish;
    end
endmodule

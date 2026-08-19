`timescale 1ns/1ps
module tb_gates4;
    reg  [3:0] in;
    wire y_and, y_or, y_xor;

    and4 u_and (.in(in), .y(y_and));
    or4  u_or  (.in(in), .y(y_or));
    xor4 u_xor (.in(in), .y(y_xor));

    integer i;
    initial begin
        $display(" in    AND OR XOR");
        for (i = 0; i < 16; i = i + 1) begin
            in = i[3:0];
            #1;
            $display("%b   %b   %b   %b", in, y_and, y_or, y_xor);
        end
        $finish;
    end
endmodule

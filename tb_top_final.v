`timescale 1ns/1ps
module tb_top_final;
    reg  [3:0] A, B;
    reg         ctrl, SHIFT;
    reg  [2:0] sel;
    wire        Y;
    wire [3:0] shiftedA;

    top_final dut (.A(A), .B(B), .ctrl(ctrl), .SHIFT(SHIFT), .sel(sel), .Y(Y), .shiftedA(shiftedA));

    integer i;
    initial begin
        A = 4'b1010; B = 4'b0110; ctrl = 0; SHIFT = 1;
        #1;
        $display("A=%b  B=%b  ctrl=%b  SHIFT=%b  shiftedA=%b", A, B, ctrl, SHIFT, shiftedA);
        $display("sel  ->  Y   meaning");
        for (i = 0; i < 8; i = i + 1) begin
            sel = i[2:0];
            #1;
            case (i)
                0: $display(" %0d   ->  %b   AND4(A)",  i, Y);
                1: $display(" %0d   ->  %b   OR4(A)",   i, Y);
                2: $display(" %0d   ->  %b   XOR4(A)",  i, Y);
                3: $display(" %0d   ->  %b   Sum[0] (A%sB)", i, Y, ctrl ? "-" : "+");
                4: $display(" %0d   ->  %b   Carry/Borrow out", i, Y);
                5: $display(" %0d   ->  %b   Comparator E (A==B)", i, Y);
                6: $display(" %0d   ->  %b   Comparator G (A>B)",  i, Y);
                7: $display(" %0d   ->  %b   Comparator L (A<B)",  i, Y);
            endcase
        end
        $finish;
    end
endmodule

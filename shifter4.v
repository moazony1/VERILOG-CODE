// ============================================================
// shifter4.v
// 4-bit shifter built from 2:1 muxes (AND-OR structure), same
// idea as the hand-drawn design in the report:
// SHIFT = 0 -> output passes the input straight through
// SHIFT = 1 -> output is shifted right by 1 bit, 0 fed into MSB
// ============================================================
module mux2to1 (
    input  wire d0,
    input  wire d1,
    input  wire sel,
    output wire y
);
    // classic AND-OR-INVERT-free 2:1 mux
    assign y = (~sel & d0) | (sel & d1);
endmodule

module shifter4 (
    input  wire [3:0] Bit,     // Bit3 Bit2 Bit1 Bit0 (Bit[3]=Bit3 ... Bit[0]=Bit0)
    input  wire        SHIFT,
    output wire [3:0] Y        // Y3 Y2 Y1 Y0
);
    // Y3: shift-in value is 0
    mux2to1 m3 (.d0(Bit[3]), .d1(1'b0),    .sel(SHIFT), .y(Y[3]));
    // Y2: shift-in value is Bit3
    mux2to1 m2 (.d0(Bit[2]), .d1(Bit[3]), .sel(SHIFT), .y(Y[2]));
    // Y1: shift-in value is Bit2
    mux2to1 m1 (.d0(Bit[1]), .d1(Bit[2]), .sel(SHIFT), .y(Y[1]));
    // Y0: shift-in value is Bit1
    mux2to1 m0 (.d0(Bit[0]), .d1(Bit[1]), .sel(SHIFT), .y(Y[0]));
endmodule

// ============================================================
// gates4.v
// 4-input logic gates (AND, OR, XOR) - each takes 4 bits and
// produces a single bit output, exactly like the report's
// "Logic operations" section.
// ============================================================
module and4 (
    input  wire [3:0] in,
    output wire        y
);
    assign y = in[0] & in[1] & in[2] & in[3];
endmodule

module or4 (
    input  wire [3:0] in,
    output wire        y
);
    assign y = in[0] | in[1] | in[2] | in[3];
endmodule

module xor4 (
    input  wire [3:0] in,
    output wire        y
);
    assign y = in[0] ^ in[1] ^ in[2] ^ in[3];
endmodule

// ============================================================
// adder_subtractor4.v
// 4-bit full-adder / full-subtractor combined circuit.
// ctrl = 0 -> Adder     : Sum = A + B
// ctrl = 1 -> Subtractor: Sum = A + (~B) + 1 = A - B  (2's complement)
// The controller feeds Cin of the first full adder and is XORed
// with every bit of B, exactly as described in the report.
// ============================================================
module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module adder_subtractor4 (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire        ctrl,   // 0 = add , 1 = subtract
    output wire [3:0] S,
    output wire        cout,   // final carry / borrow-out
    output wire        overflow
);
    wire [3:0] B_xor;
    wire [3:0] carry;

    // each bit of B is XORed with the controller
    assign B_xor = B ^ {4{ctrl}};

    full_adder fa0 (.a(A[0]), .b(B_xor[0]), .cin(ctrl),     .sum(S[0]), .cout(carry[0]));
    full_adder fa1 (.a(A[1]), .b(B_xor[1]), .cin(carry[0]), .sum(S[1]), .cout(carry[1]));
    full_adder fa2 (.a(A[2]), .b(B_xor[2]), .cin(carry[1]), .sum(S[2]), .cout(carry[2]));
    full_adder fa3 (.a(A[3]), .b(B_xor[3]), .cin(carry[2]), .sum(S[3]), .cout(carry[3]));

    assign cout     = carry[3];
    // overflow detection (signed): carry into MSB differs from carry out of MSB
    assign overflow = carry[2] ^ carry[3];
endmodule

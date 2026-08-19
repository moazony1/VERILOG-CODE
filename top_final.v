// ============================================================
// mux8to1.v : simple 8:1 multiplexer used for the final delivery
// ============================================================
module mux8to1 (
    input  wire [7:0] D,     // D0..D7
    input  wire [2:0] sel,
    output wire        Y
);
    assign Y = D[sel];
endmodule

// ============================================================
// top_final.v
// Ties every circuit from the report together and feeds their
// single-bit results into an 8x1 MUX so one selector chooses
// which operation's result is displayed on the output LED,
// exactly like the "final delivery" section of the report.
//
// sel = 000 -> AND4(A)
// sel = 001 -> OR4(A)
// sel = 010 -> XOR4(A)
// sel = 011 -> Adder/Sub S[0]   (LSB of A+B or A-B, per ctrl)
// sel = 100 -> Adder/Sub cout   (carry-out / borrow)
// sel = 101 -> Comparator E (A == B)
// sel = 110 -> Comparator G (A > B)
// sel = 111 -> Comparator L (A < B)
// ============================================================
module top_final (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire        ctrl,     // 0 = add , 1 = subtract
    input  wire        SHIFT,    // kept available, not routed to mux in this example
    input  wire [2:0] sel,      // chooses which result reaches Y
    output wire        Y,
    output wire [3:0] shiftedA   // shifter output, shown separately
);
    wire y_and, y_or, y_xor;
    wire [3:0] S;
    wire cout, overflow;
    wire E, G, L;
    wire [7:0] D;

    and4 u_and (.in(A), .y(y_and));
    or4  u_or  (.in(A), .y(y_or));
    xor4 u_xor (.in(A), .y(y_xor));

    adder_subtractor4 u_addsub (.A(A), .B(B), .ctrl(ctrl), .S(S), .cout(cout), .overflow(overflow));

    comparator4 u_cmp (.A(A), .B(B), .E(E), .G(G), .L(L));

    shifter4 u_shift (.Bit(A), .SHIFT(SHIFT), .Y(shiftedA));

    assign D = {L, G, E, cout, S[0], y_xor, y_or, y_and};

    mux8to1 u_mux (.D(D), .sel(sel), .Y(Y));
endmodule

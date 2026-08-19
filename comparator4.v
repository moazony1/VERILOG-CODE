// ============================================================
// comparator4.v
// 4-bit magnitude comparator, implemented exactly with the
// equations written in the report:
//   E = (A3 XNOR B3).(A2 XNOR B2).(A1 XNOR B1).(A0 XNOR B0)
//   G = A3.~B3
//       + (A3 XNOR B3).A2.~B2
//       + (A3 XNOR B3).(A2 XNOR B2).A1.~B1
//       + (A3 XNOR B3).(A2 XNOR B2).(A1 XNOR B1).A0.~B0
//   L = ~E . ~G
// E = Equal , G = A>B , L = A<B
// ============================================================
module comparator4 (
    input  wire [3:0] A,   // A3 A2 A1 A0  -> A[3:0]
    input  wire [3:0] B,   // B3 B2 B1 B0  -> B[3:0]
    output wire        E,
    output wire        G,
    output wire        L
);
    wire xnor3, xnor2, xnor1, xnor0;

    assign xnor3 = ~(A[3] ^ B[3]);
    assign xnor2 = ~(A[2] ^ B[2]);
    assign xnor1 = ~(A[1] ^ B[1]);
    assign xnor0 = ~(A[0] ^ B[0]);

    assign E = xnor3 & xnor2 & xnor1 & xnor0;

    assign G = (A[3] & ~B[3])
             | (xnor3 & A[2] & ~B[2])
             | (xnor3 & xnor2 & A[1] & ~B[1])
             | (xnor3 & xnor2 & xnor1 & A[0] & ~B[0]);

    assign L = ~E & ~G;
endmodule

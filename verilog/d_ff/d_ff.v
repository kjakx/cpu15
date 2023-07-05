module d_ff(CLK, D, Q);
    input CLK, D;
    output Q;
    reg q;

    always @(posedge CLK)
        q <= D;

    assign Q = q;
endmodule

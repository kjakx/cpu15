module cpu_dec_slow(
    input CLK,
    input RESET_N,
    input[15:0] IO65_IN,
    output[15:0] IO64_OUT,
    output[6:0] HEX4,
    output[6:0] HEX3,
    output[6:0] HEX2,
    output[6:0] HEX1,
    output[6:0] HEX0
);
    wire clk_slow;

    clk_down C1(
        .CLK_IN(CLK),
        .CLK_OUT(clk_slow)
    );

    cpu_dec C2(
        .CLK(clk_slow),
        .RESET_N(RESET_N),
        .IO65_IN(IO65_IN),
        .IO64_OUT(IO64_OUT),
        .HEX4(HEX4),
        .HEX3(HEX3),
        .HEX2(HEX2),
        .HEX1(HEX1),
        .HEX0(HEX0)
    );
endmodule
module cpu_dec(
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
    wire[15:0] io64_out_tp;
    wire[3:0] dec_out4;
    wire[3:0] dec_out3;
    wire[3:0] dec_out2;
    wire[3:0] dec_out1;
    wire[3:0] dec_out0;
    wire[13:0] reminder4;
    wire[9:0] reminder3;
    wire[6:0] reminder2;

    cpu15 C1(
        .CLK(CLK),
        .RESET_N(RESET_N),
        .IO65_IN(IO65_IN & 16'b0000001111111111),
        .IO64_OUT(io64_out_tp)
    );

    bin_dec10000 C2(
        .BIN_IN(io64_out_tp),
        .DEC_OUT4(dec_out4),
        .REMINDER4(reminder4)
    );

    bin_dec1000 C3(
        .BIN_IN3(reminder4),
        .DEC_OUT3(dec_out3),
        .REMINDER3(reminder3)
    );

    bin_dec100 C4(
        .BIN_IN2(reminder3),
        .DEC_OUT2(dec_out2),
        .REMINDER2(reminder2)
    );

    bin_dec10 C5(
        .BIN_IN1(reminder2),
        .DEC_OUT1(dec_out1),
        .REMINDER1(dec_out0)
    );

    dec_7seg C6(
        .DIN(dec_out4),
        .SEG7(HEX4)
    );

    dec_7seg C7(
        .DIN(dec_out3),
        .SEG7(HEX3)
    );

    dec_7seg C8(
        .DIN(dec_out2),
        .SEG7(HEX2)
    );

    dec_7seg C9(
        .DIN(dec_out1),
        .SEG7(HEX1)
    );

    dec_7seg C10(
        .DIN(dec_out0),
        .SEG7(HEX0)
    );

    assign IO64_OUT = io64_out_tp;
endmodule
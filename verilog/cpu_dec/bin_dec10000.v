module bin_dec10000(
    input[15:0] BIN_IN,
    output reg[3:0] DEC_OUT4,
    output[13:0] REMINDER4
);
    integer cmp_int;
    integer rem_int;
    always @(BIN_IN) begin
        cmp_int = BIN_IN;
        if (cmp_int > 59999) begin
            DEC_OUT4 <= 4'd6;
            rem_int <= cmp_int - 60000;
        end
        else if (cmp_int > 49999) begin
            DEC_OUT4 <= 4'd5;
            rem_int <= cmp_int - 50000;
        end
        else if (cmp_int > 39999) begin
            DEC_OUT4 <= 4'd4;
            rem_int <= cmp_int - 40000;
        end
        else if (cmp_int > 29999) begin
            DEC_OUT4 <= 4'd3;
            rem_int <= cmp_int - 30000;
        end
        else if (cmp_int > 19999) begin
            DEC_OUT4 <= 4'd2;
            rem_int <= cmp_int - 20000;
        end
        else if (cmp_int > 9999) begin
            DEC_OUT4 <= 4'd1;
            rem_int <= cmp_int - 10000;
        end
        else begin
            DEC_OUT4 <= 4'd0;
            rem_int <= cmp_int;
        end
    end
    assign REMINDER4 = rem_int;
endmodule
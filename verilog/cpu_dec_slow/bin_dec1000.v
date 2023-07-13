module bin_dec1000(
    input[13:0] BIN_IN3,
    output reg[3:0] DEC_OUT3,
    output[9:0] REMINDER3
);
    integer cmp_int;
    integer rem_int;
    always @(BIN_IN3) begin
        cmp_int = BIN_IN3;
        if (cmp_int > 8999) begin
            DEC_OUT3 <= 4'd9;
            rem_int <= cmp_int - 9000;
        end
        else if (cmp_int > 7999) begin
            DEC_OUT3 <= 4'd8;
            rem_int <= cmp_int - 8000;
        end
        else if (cmp_int > 6999) begin
            DEC_OUT3 <= 4'd7;
            rem_int <= cmp_int - 7000;
        end
        else if (cmp_int > 5999) begin
            DEC_OUT3 <= 4'd6;
            rem_int <= cmp_int - 6000;
        end
        else if (cmp_int > 4999) begin
            DEC_OUT3 <= 4'd5;
            rem_int <= cmp_int - 5000;
        end
        else if (cmp_int > 3999) begin
            DEC_OUT3 <= 4'd4;
            rem_int <= cmp_int - 4000;
        end
        else if (cmp_int > 2999) begin
            DEC_OUT3 <= 4'd3;
            rem_int <= cmp_int - 3000;
        end
        else if (cmp_int > 1999) begin
            DEC_OUT3 <= 4'd2;
            rem_int <= cmp_int - 2000;
        end
        else if (cmp_int > 999) begin
            DEC_OUT3 <= 4'd1;
            rem_int <= cmp_int - 1000;
        end
        else begin
            DEC_OUT3 <= 4'd0;
            rem_int <= cmp_int;
        end
    end
    assign REMINDER3 = rem_int;
endmodule
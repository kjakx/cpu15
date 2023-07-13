module bin_dec10(
    input[6:0] BIN_IN1,
    output reg[3:0] DEC_OUT1,
    output[3:0] REMINDER1
);
    integer cmp_int;
    integer rem_int;
    always @(BIN_IN1) begin
        cmp_int = BIN_IN1;
        if (cmp_int > 89) begin
            DEC_OUT1 <= 4'd9;
            rem_int <= cmp_int - 90;
        end
        else if (cmp_int > 79) begin
            DEC_OUT1 <= 4'd8;
            rem_int <= cmp_int - 80;
        end
        else if (cmp_int > 69) begin
            DEC_OUT1 <= 4'd7;
            rem_int <= cmp_int - 70;
        end
        else if (cmp_int > 59) begin
            DEC_OUT1 <= 4'd6;
            rem_int <= cmp_int - 60;
        end
        else if (cmp_int > 49) begin
            DEC_OUT1 <= 4'd5;
            rem_int <= cmp_int - 50;
        end
        else if (cmp_int > 39) begin
            DEC_OUT1 <= 4'd4;
            rem_int <= cmp_int - 40;
        end
        else if (cmp_int > 29) begin
            DEC_OUT1 <= 4'd3;
            rem_int <= cmp_int - 30;
        end
        else if (cmp_int > 19) begin
            DEC_OUT1 <= 4'd2;
            rem_int <= cmp_int - 20;
        end
        else if (cmp_int > 9) begin
            DEC_OUT1 <= 4'd1;
            rem_int <= cmp_int - 10;
        end
        else begin
            DEC_OUT1 <= 4'd0;
            rem_int <= cmp_int;
        end
    end
    assign REMINDER1 = rem_int;
endmodule

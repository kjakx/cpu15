module bin_dec100(
    input[9:0] BIN_IN2,
    output reg[3:0] DEC_OUT2,
    output[6:0] REMINDER2
);
    integer cmp_int;
    integer rem_int;
    always @(BIN_IN2) begin
        cmp_int = BIN_IN2;
        if (cmp_int > 899) begin
            DEC_OUT2 <= 4'd9;
            rem_int <= cmp_int - 900;
        end
        else if (cmp_int > 799) begin
            DEC_OUT2 <= 4'd8;
            rem_int <= cmp_int - 800;
        end
        else if (cmp_int > 699) begin
            DEC_OUT2 <= 4'd7;
            rem_int <= cmp_int - 700;
        end
        else if (cmp_int > 599) begin
            DEC_OUT2 <= 4'd6;
            rem_int <= cmp_int - 600;
        end
        else if (cmp_int > 499) begin
            DEC_OUT2 <= 4'd5;
            rem_int <= cmp_int - 500;
        end
        else if (cmp_int > 399) begin
            DEC_OUT2 <= 4'd4;
            rem_int <= cmp_int - 400;
        end
        else if (cmp_int > 299) begin
            DEC_OUT2 <= 4'd3;
            rem_int <= cmp_int - 300;
        end
        else if (cmp_int > 199) begin
            DEC_OUT2 <= 4'd2;
            rem_int <= cmp_int - 200;
        end
        else if (cmp_int > 99) begin
            DEC_OUT2 <= 4'd1;
            rem_int <= cmp_int - 100;
        end
        else begin
            DEC_OUT2 <= 4'd0;
            rem_int <= cmp_int;
        end
    end
    assign REMINDER2 = rem_int;
endmodule
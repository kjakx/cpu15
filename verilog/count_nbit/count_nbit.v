module count_nbit(CLK, RST, COUNT_N);
    parameter N_BIT = 8;
    input CLK, RST;
    output[N_BIT-1:0] COUNT_N;
    reg[N_BIT-1:0] count_n;

    initial count_n = 0;
    always @(posedge CLK) begin
        if (RST == 1'b1)
            count_n <= {N_BIT{1'b0}};
        else
            count_n <= count_n + 1;
    end

    assign COUNT_N = count_n;
endmodule

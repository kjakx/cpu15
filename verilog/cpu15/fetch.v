module fetch(
    input CLK_FT,
    input[3:0] P_COUNT,
    output[14:0] PROM_OUT
);
    reg[14:0] mem[15:0];
    integer i;

    initial begin
        mem[0] = 100100000000000;
        mem[1] = 100000000000000;
        mem[2] = 100100100000000;
        mem[3] = 100000100000001;
        mem[4] = 100101000000000;
        mem[5] = 100001000000000;
        mem[6] = 100101100000000;
        mem[7] = 100001100001010;
        mem[8] = 000101000100000;
        mem[9] = 000100001000000;
        mem[10] = 111000001000000;
        mem[11] = 101001001100000;
        mem[12] = 101100000001110;
        mem[13] = 110000000001000;
        mem[14] = 111100000000000;
        mem[15] = 000000000000000;
    end

    always @(posedge CLK_FT) begin
        i <= P_COUNT;
    end

    assign PROM_OUT = mem[i];
endmodule

module fetch(
    input CLK_FT,
    input[7:0] P_COUNT,
    output reg [14:0] PROM_OUT
);
    reg[14:0] mem[15:0];

    initial begin
        mem[0] = 15'b100100000000000;
        mem[1] = 15'b100000000000000;
        mem[2] = 15'b100100100000000;
        mem[3] = 15'b100000100000001;
        mem[4] = 15'b100101000000000;
        mem[5] = 15'b100001000000000;
        mem[6] = 15'b100101100000001;
        mem[7] = 15'b100001101101001;
        mem[8] = 15'b000101000100000;
        mem[9] = 15'b000100001000000;
        mem[10] = 15'b111000001000000;
        mem[11] = 15'b101001001100000;
        mem[12] = 15'b101100000001110;
        mem[13] = 15'b110000000001000;
        mem[14] = 15'b111100000000000;
        mem[15] = 15'b000000000000000;
    end

    always @(posedge CLK_FT) begin
        PROM_OUT <= mem[P_COUNT[3:0]];
    end
endmodule

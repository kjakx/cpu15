module fetch(
    input CLK_FT,
    input[7:0] P_COUNT,
    output reg [14:0] PROM_OUT
);
    reg[14:0] mem[15:0];

    initial begin
        mem[0] = 15'b100100000000000; // ldh Reg0, 0
        mem[1] = 15'b100000000000000; // ldl Reg0, 0
        mem[2] = 15'b100100100000000; // ldh Reg1, 0
        mem[3] = 15'b100000100000001; // ldl Reg1, 1
        mem[4] = 15'b100101000000000; // ldh Reg2, 0
        mem[5] = 15'b100001000000000; // ldh Reg2, 0
        mem[6] = 15'b110101101000001; // ld Reg3, 65
        mem[7] = 15'b000101000100000; // add Reg2, Reg1
        mem[8] = 15'b000100001000000; // add Reg0, Reg2
        mem[9] = 15'b111000001000000; // st Reg0, 64
        mem[10] = 15'b101001001100000; // cmp Reg2, Reg3
        mem[11] = 15'b101100000001101; // je 13(Dh)
        mem[12] = 15'b110000000000111; // jmp 7(7h)
        mem[13] = 15'b111100000000000; // hlt
        mem[14] = 15'b000000000000000; // nop
        mem[15] = 15'b000000000000000; // nop
    end

    always @(posedge CLK_FT) begin
        PROM_OUT <= mem[P_COUNT[3:0]];
    end
endmodule
module ram_wb(
    input CLK_WB,
    input[7:0] RAM_ADDR,
    input[15:0] RAM_IN,
    input RAM_WEN,
    output reg[15:0] RAM_0,
    output reg[15:0] RAM_1,
    output reg[15:0] RAM_2,
    output reg[15:0] RAM_3,
    output reg[15:0] RAM_4,
    output reg[15:0] RAM_5,
    output reg[15:0] RAM_6,
    output reg[15:0] RAM_7,
    output reg[15:0] IO64_OUT
);

    always @(posedge CLK_WB) begin
        if (RAM_WEN == 1'b1) begin
            case (RAM_ADDR)
                8'b00000000: RAM_0 <= RAM_IN;
                8'b00000001: RAM_1 <= RAM_IN;
                8'b00000010: RAM_2 <= RAM_IN;
                8'b00000011: RAM_3 <= RAM_IN;
                8'b00000100: RAM_4 <= RAM_IN;
                8'b00000101: RAM_5 <= RAM_IN;
                8'b00000110: RAM_6 <= RAM_IN;
                8'b00000111: RAM_7 <= RAM_IN;
                8'b01000000: IO64_OUT <= RAM_IN;
                default: ; // nothing to do
            endcase
        end
    end
endmodule

module ram_dc(
    input CLK_DC,
    input[7:0] RAM_AD_IN,
    input[15:0] RAM_0,
    input[15:0] RAM_1,
    input[15:0] RAM_2,
    input[15:0] RAM_3,
    input[15:0] RAM_4,
    input[15:0] RAM_5,
    input[15:0] RAM_6,
    input[15:0] RAM_7,
    input[15:0] IO65_IN,
    output[7:0] RAM_AD_OUT,
    output[15:0] RAM_OUT
);
    reg[7:0] RAM_AD_OUT;
    reg[15:0] RAM_OUT;

    always @(posedge CLK_DC) begin
        case (RAM_AD_IN)
            8'b00000000: RAM_OUT = RAM_0;
            8'b00000001: RAM_OUT = RAM_1;
            8'b00000010: RAM_OUT = RAM_2;
            8'b00000011: RAM_OUT = RAM_3;
            8'b00000100: RAM_OUT = RAM_4;
            8'b00000101: RAM_OUT = RAM_5;
            8'b00000110: RAM_OUT = RAM_6;
            8'b00000111: RAM_OUT = RAM_7;
            8'b01000001: RAM_OUT = IO65_IN;
            default: ; // nothing to do
        endcase

        RAM_AD_OUT <= RAM_AD_IN;
    end
endmodule

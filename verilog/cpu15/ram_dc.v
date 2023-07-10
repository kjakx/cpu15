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
    reg[7:0] ram_ad_out;
    reg[15:0] ram_out;

    function[15:0] ram;
        input[7:0] addr;
        case (addr)
            00000000: ram_out = RAM_0;
            00000001: ram_out = RAM_1;
            00000010: ram_out = RAM_2;
            00000011: ram_out = RAM_3;
            00000100: ram_out = RAM_4;
            00000101: ram_out = RAM_5;
            00000110: ram_out = RAM_6;
            00000111: ram_out = RAM_7;
            01000001: ram_out = IO65_IN;
            default: ram_out = 15'bx;
        endcase
    endfunction

    always @(posedge CLK_DC) begin
        ram_out <= ram(RAM_AD_IN);
        ram_ad_out <= RAM_AD_IN;
    end

    assign RAM_OUT = ram_out;
    assign RAM_AD_OUT = ram_ad_out;
endmodule

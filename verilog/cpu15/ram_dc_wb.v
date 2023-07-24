module ram_dc_wb(
    input CLK_DC,
    input CLK_WB,
    input[7:0] RAM_ADDR,
    input[15:0] RAM_IN,
    input[15:0] IO65_IN,
    input RAM_WEN,
    output reg[15:0] RAM_OUT,
    output reg[15:0] IO64_OUT
);

reg[15:0] ram_array[0:63];
integer i;

initial begin
    for (i = 0; i < 64; i = i + 1)
        ram_array[i] <= 16'b0;
end

always @(posedge CLK_DC) begin
    if (RAM_ADDR < 8'd64)
        RAM_OUT <= ram_array[RAM_ADDR];
    else if (RAM_ADDR == 8'd65)
        RAM_OUT <= IO65_IN;
end

always @(posedge CLK_WB) begin
    if (RAM_WEN == 1'b1)
        if (RAM_ADDR < 8'd64)
            ram_array[RAM_ADDR] <= RAM_IN;
        else if (RAM_ADDR == 8'd64)
            IO64_OUT <= RAM_IN;
end

endmodule
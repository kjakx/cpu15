module mega_ram(
    input CLK,
    input CLK_EX,
    input[7:0] RAM_ADDR,
    input[15:0] RAM_IN,
    input[15:0] IO65_IN,
    input RAM_WEN,
    output reg[15:0] RAM_OUT,
    output reg[15:0] IO64_OUT
);

wire[15:0] ram_out_mega;
reg ram_sel;
wire ram_wren;

ram_1port C1(
    .address(RAM_ADDR[5:0]),
    .clock(CLK),
    .data(RAM_IN),
    .wren(ram_wren),
    .q(ram_out_mega)
);

always @(RAM_ADDR, ram_out_mega, IO65_IN) begin
    if (RAM_ADDR < 8'd64) begin
        RAM_OUT <= ram_out_mega;
        ram_sel <= 1'b1;
    end
    else if (RAM_ADDR == 8'd65) begin
        RAM_OUT <= IO65_IN;
        ram_sel <= 1'b0;
    end
    else begin
        RAM_OUT <= 16'b0;
        ram_sel <= 1'b0;
    end
end

always @(posedge CLK) begin
    if (RAM_ADDR == 8'd64)
        if(RAM_WEN == 1'b1 && CLK_EX == 1'b1)
            IO64_OUT <= RAM_IN;
end

assign ram_wren = RAM_WEN & CLK_EX & ram_sel;
endmodule
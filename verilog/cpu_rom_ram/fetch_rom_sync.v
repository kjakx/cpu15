module fetch_rom_sync(
    input CLK,
    input CLK_FT,
    input[7:0] P_COUNT,
    output reg[14:0] PROM_OUT
);

wire[14:0] q;

fetch_rom C1(
    .address(P_COUNT),
    .clock(CLK),
    .q(q),
);

always @(posedge CLK) begin
    if (CLK_FT == 1'b1)
        PROM_OUT <= q;
end
endmodule
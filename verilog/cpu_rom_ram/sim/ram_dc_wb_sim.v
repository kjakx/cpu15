`timescale 1ns/100ps

module ram_dc_wb_sim(
    output[15:0] ram_out_out
);

reg clk_dc = 1'b0;
reg clk_wb = 1'b0;
reg[7:0] ram_addr = 8'b0;
reg[15:0] ram_in = 16'b0;
reg[15:0] io65_in = 16'b0;
reg ram_wen = 1'b0;
wire[15:0] ram_out;
wire[15:0] io64_out;
integer i;

ram_dc_wb C1(
    .CLK_DC(clk_dc),
    .CLK_WB(clk_wb),
    .RAM_ADDR(ram_addr),
    .RAM_IN(ram_in),
    .IO65_IN(io65_in),
    .RAM_WEN(ram_wen),
    .RAM_OUT(ram_out),
    .IO64_OUT(io64_out)
);

parameter T = 40;

always begin
    #(T/4) clk_dc <= 1'b1;
    #(T/4) clk_dc <= 1'b0;
    #(T/2) ;
end

always begin
    #(3*T/4) clk_wb <= 1'b1;
    #(T/4) clk_wb <= 1'b0;
end

always begin
    ram_addr <= 8'b0;
    for (i = 0; i < 16; i = i + 1)
        #(T) ram_addr <= ram_addr + 1;
end

always begin
    ram_in <= 16'b0000000000000010;
    #(T)
    ram_in <= 16'b0000000000000100;
    #(T)
    ram_in <= 16'b0000000000000110;
    #(T)
    ram_in <= 16'b0000000000001000;
    #(T)
    ram_in <= 16'b0000000000000111;
    #(T)
    ram_in <= 16'b0000000000000101;
    #(T)
    ram_in <= 16'b0000000000000011;
    #(T) ;
end

initial begin
    ram_wen <= 1'b1;
    #(16*T)
    ram_wen <= 1'b0;
    #(16*T)
    $stop;
end

assign ram_out_out = ram_out;
endmodule
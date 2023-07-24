`timescale 1ns/100ps

module mega_ram_sim(
    output[15:0] q
);

reg clk = 1'b1;
reg clk_ex = 1'b0;
reg[7:0] ram_addr;
reg[15:0] ram_in;
wire[15:0] io65_in;
reg ram_wen = 1'b0;
wire[15:0] ram_out;
wire[15:0] io64_out;

mega_ram C1(
    .CLK(clk),
    .CLK_EX(clk_ex),
    .RAM_ADDR(ram_addr),
    .RAM_IN(ram_in),
    .IO65_IN(io65_in),
    .RAM_WEN(ram_wen),
    .RAM_OUT(ram_out),
    .IO64_OUT(io64_out)
);

parameter T = 20;

// clk
always begin
    clk <= 1'b1;
    #(T/2)
    clk <= 1'b0;
    #(T/2) ;
end

// clk_ex
always begin
    clk_ex <= 1'b0;
    #2
    clk_ex <= 1'b1;
    #20
    clk_ex <= 1'b0;
    #58 ;
end

// ram_addr
initial begin
    ram_addr <= 8'd1;
    #44
    ram_addr <= 8'd2;
    #80
    ram_addr <= 8'd3;
    #80
    ram_addr <= 8'd4;
    #80 ;
end

// ram_in
initial begin
    ram_in <= 16'd0;
    #4
    ram_in <= 16'd2;
    #80
    ram_in <= 16'd4;
    #80
    ram_in <= 16'd6;
    #80
    ram_in <= 16'd8;
    #80 ;
end

// ram_wen
initial begin
    ram_wen <= 1'b0;
    #164
    ram_wen <= 1'b1;
    #80
    ram_wen <= 1'b0;
    #36 $stop;
end

assign q = ram_out;
endmodule
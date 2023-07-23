`timescale 1ns/100ps

module ram_dc_wb_sim(
    output[15:0] q_out
);

reg[5:0] address;
reg clk = 1'b0;
reg[15:0] data;
reg wren = 1'b0;
wire[15:0] q;

ram_1port C1(
    .address(address),
    .clock(clk),
    .data(data),
    .wren(wren),
    .q(q)
);

parameter T = 20;

// clock
always begin
    #(T/2) clk <= 1'b1;
    #(T/2) clk <= 1'b0;
end

// address
initial begin
    address <= 6'b000001;
    #(2*T) address <= 6'b000011;
    #(2*T) address <= 6'b000001;
    #(2*T) $stop;
end

// data
always begin
    data <= 16'b0000000000000010;
    #(2*T)
    data <= 16'b0000000000000100;
    #(2*T)
    data <= 16'b0000000000000110;
    #(2*T) ;
end

// wren
always begin
    #(T) wren <= 1'b1;
    #(T) wren <= 1'b0;
end

assign q_out = q;
endmodule
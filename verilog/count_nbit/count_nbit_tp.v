`timescale 1ps/1ps

module count_nbit_tp;
    reg clk, rst;
    wire[3:0] count;

    parameter STEP = 1000;
    always #(STEP/2)
        clk = ~clk;

    defparam count_nbit.N_BIT = 4;
    count_nbit count_nbit(clk, rst, count);

    initial begin
                clk = 0; rst = 0;
        #(STEP*15)   rst = 0;
        #(STEP)   rst = 0;
        #(STEP)   rst = 1;
        #(STEP)   rst = 0;
        #(STEP)   $finish;
    end

    initial $monitor($stime, " clk=%b rst=%b count=%h", clk, rst, count);
endmodule

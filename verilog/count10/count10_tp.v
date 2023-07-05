`timescale 1ps/1ps

module count10_tp;
    reg clk, rst;
    wire[3:0] count;

    parameter STEP = 1000;
    always #(STEP/2)
        clk = ~clk;

    count10 count10(clk, rst, count);

    initial begin
                clk = 1; rst = 0;
        #(STEP*9)   rst = 0;
        #(STEP)   rst = 0;
        #(STEP)   rst = 0;
        #(STEP)   rst = 1;
        #(STEP)   $finish;
    end

    initial $monitor($stime, " clk=%b rst=%b count=%h", clk, rst, count);
endmodule

`timescale 1ps/1ps

module d_ff_tp;
    reg clk, d;
    wire q;

    parameter STEP = 100000;
    always #(STEP/2)
        clk = ~clk;

    d_ff d_ff(clk, d, q);

    initial begin
                clk = 1; d = 0;
        #(STEP/2)   d = 1;
        #(STEP/2)   d = 1;
        #(STEP/2)   d = 0;
        #(STEP/2)   d = 0;
        #(STEP/2)   $finish;
    end

    initial $monitor($stime, " clk=%b d=%b q=%b", clk, d, q);
endmodule

`timescale 1ns/1ns

module dec_7seg_tp;
    reg[3:0] din;
    wire[6:0] seg7;
    integer i;

    parameter STEP = 10;

    dec_7seg dec_7seg(din, seg7);

    initial begin
        din = 4'b0;
        for (i = 0; i < 16; i++)
            #(STEP) din = din + 4'b1;
        
        $finish;
    end

    initial $monitor($stime, " din=%b seg7=%b", din, seg7);
endmodule

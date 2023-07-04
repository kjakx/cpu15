`timescale 1ps/1ps

module half_adder_tp;
    reg a, b;
    wire s, co;

    parameter STEP = 100000;

    half_adder half_adder(a, b, s, co);

    initial begin
                a = 0; b = 0;
        #STEP   a = 0; b = 1;
        #STEP   a = 1; b = 0;
        #STEP   a = 1; b = 1;
        #STEP   $finish;
    end

    initial $monitor($stime, " a=%b b=%b s=%b co=%b", a, b, s, co);
endmodule

`timescale 1ps/1ps

module full_adder_tp;
    reg a, b, ci;
    wire s, co;

    parameter STEP = 100000;

    full_adder half_adder(a, b, ci, s, co);

    initial begin
                a = 0; b = 0; ci = 0;
        #STEP   a = 0; b = 1; ci = 0;
        #STEP   a = 1; b = 0; ci = 0;
        #STEP   a = 1; b = 1; ci = 0;
        #STEP   a = 0; b = 0; ci = 1;
        #STEP   a = 0; b = 1; ci = 1;
        #STEP   a = 1; b = 0; ci = 1;
        #STEP   a = 1; b = 1; ci = 1;
        #STEP   $finish;
    end

    initial $monitor($stime, " a=%b b=%b ci=%b s=%b co=%b", a, b, ci, s, co);
endmodule

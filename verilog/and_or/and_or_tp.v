`timescale 1ps/1ps

module and_or_tp;
    reg a, b;
    wire z_and, z_or;

    parameter STEP = 100000;

    and_or and_or(a, b, z_and, z_or);

    initial begin
                a = 0; b = 0;
        #STEP   a = 0; b = 1;
        #STEP   a = 1; b = 0;
        #STEP   a = 1; b = 1;
        #STEP   $finish;
    end

    initial $monitor($stime, " a=%b b=%b z_and=%b z_or=%b", a, b, z_and, z_or);
endmodule

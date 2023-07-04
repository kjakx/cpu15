`timescale 1ps/1ps

module adder_4bit_tp;
    reg[3:0] a, b;
    wire[4:0] s;

    parameter STEP = 100000;

    adder_4bit adder_4bit(a, b, s);

    initial begin
                a = 4'h0; b = 4'h0;
        #STEP   a = 4'h0; b = 4'h1;
        #STEP   a = 4'h1; b = 4'h1;
        #STEP   a = 4'h1; b = 4'h2;
        #STEP   a = 4'h2; b = 4'h3;
        #STEP   a = 4'h3; b = 4'h5;
        #STEP   a = 4'h5; b = 4'h8;
        #STEP   a = 4'h8; b = 4'hD;
        #STEP   $finish;
    end

    initial $monitor($stime, " a=%h b=%h s=%h", a, b, s);
endmodule

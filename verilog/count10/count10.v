module count10(CLK, RST, COUNT);
    input CLK, RST;
    output[3:0] COUNT;
    reg[3:0] count;

    initial count = 0;

    always @(posedge CLK) begin
        if (RST == 1'b1)
            count <= 4'b0;
        else if (count == 4'h9)
            count <= 4'b0;
        else
            count <= count + 4'b1;
    end

    assign COUNT = count;
endmodule

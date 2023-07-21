module clk_gen(
    input CLK,
    output CLK_FT,
    output CLK_DC,
    output CLK_EX,
    output CLK_WB
);
    reg[3:0] clk = 4'b0;
    reg[1:0] count = 2'b0;
    
    always @(posedge CLK) begin
        case (count)
            2'b00: clk = 4'b0001;
            2'b01: clk = 4'b0010;
            2'b10: clk = 4'b0100;
            2'b11: clk = 4'b1000;
            default: ; // nothing to do
        endcase
    
        count <= count + 1;
    end

    assign CLK_FT = clk[0];
    assign CLK_DC = clk[1];
    assign CLK_EX = clk[2];
    assign CLK_WB = clk[3];
endmodule

module clk_gen(
    input CLK,
    output CLK_FT,
    output CLK_DC,
    output CLK_EX,
    output CLK_WB
);
    reg[3:0] clk = 4'b0;
    reg[1:0] count = 2'b0;
    
    function[3:0] gen_clk;
        input[1:0] cnt;
        case (cnt)
            2'b00: gen_clk = 4'b0001;
            2'b01: gen_clk = 4'b0010;
            2'b10: gen_clk = 4'b0100;
            2'b11: gen_clk = 4'b1000;
            default: gen_clk = 4'bxxxx;
        endcase
    endfunction
    
    always @(posedge CLK) begin
        clk <= gen_clk(count);
        count <= count + 1;
    end

    assign CLK_FT = clk[0];
    assign CLK_DC = clk[1];
    assign CLK_EX = clk[2];
    assign CLK_WB = clk[3];

endmodule

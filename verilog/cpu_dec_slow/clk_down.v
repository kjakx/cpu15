module clk_down(
    input CLK_IN,
    output CLK_OUT
);
    reg[20:0] count = 21'b0;
    always @(posedge CLK_IN) begin
        count <= count + 1;
    end

    assign CLK_OUT = count[20];
endmodule
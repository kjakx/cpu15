module decode(
    input CLK_DC,
    input[14:0] PROM_OUT,
    output reg[3:0] OP_CODE,
    output reg[7:0] OP_DATA
);

    always @(posedge CLK_DC) begin
        OP_CODE <= PROM_OUT[14:11];
        OP_DATA <= PROM_OUT[7:0];
    end
endmodule

module decode(
    input CLK_DC,
    input[14:0] PROM_OUT,
    output[3:0] OP_CODE,
    output[7:0] OP_DATA
);
    reg[3:0] op_code;
    reg[7:0] op_data;

    always @(posedge CLK_DC) begin
        op_code <= PROM_OUT[14:11];
        op_data <= PROM_OUT[7:0];
    end

    assign OP_CODE = op_code;
    assign OP_DATA = op_data;
endmodule

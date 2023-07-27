module n_reg_ex(
    input CLK_EX,
    input[2:0] N_REG,
    output reg[2:0] N_REG_DLY
);

always @(posedge CLK_EX)
    N_REG_DLY <= N_REG;

endmodule
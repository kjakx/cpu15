module reg_dc(
    input CLK_DC,
    input[2:0] N_REG_IN,
    input[15:0] REG_0,
    input[15:0] REG_1,
    input[15:0] REG_2,
    input[15:0] REG_3,
    input[15:0] REG_4,
    input[15:0] REG_5,
    input[15:0] REG_6,
    input[15:0] REG_7,
    output[2:0] N_REG_OUT,
    output[15:0] REG_OUT
);
    reg[2:0] N_REG_OUT;
    reg[15:0] REG_OUT;
    
    always @(posedge CLK_DC) begin
        case (N_REG_IN)
            000: REG_OUT = REG_0;
            001: REG_OUT = REG_1;
            010: REG_OUT = REG_2;
            011: REG_OUT = REG_3;
            100: REG_OUT = REG_4;
            101: REG_OUT = REG_5;
            110: REG_OUT = REG_6;
            111: REG_OUT = REG_7;
            default: ; // nothing to do
        endcase

        N_REG_OUT <= N_REG_IN;
    end
endmodule

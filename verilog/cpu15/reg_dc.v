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
    reg[2:0] n_reg_out;
    reg[15:0] reg_out;
    
    function[15:0] sel_reg;
        input[2:0] idx;
        case (idx)
            000: sel_reg = REG_0;
            001: sel_reg = REG_1;
            010: sel_reg = REG_2;
            011: sel_reg = REG_3;
            100: sel_reg = REG_4;
            101: sel_reg = REG_5;
            110: sel_reg = REG_6;
            111: sel_reg = REG_7;
            default: sel_reg = 16'bx;
        endcase
    endfunction

    always @(posedge CLK_DC) begin
        reg_out <= sel_reg(N_REG_IN);
        n_reg_out <= N_REG_IN;
    end

    assign N_REG_OUT = n_reg_out;
    assign REG_OUT = reg_out;
endmodule

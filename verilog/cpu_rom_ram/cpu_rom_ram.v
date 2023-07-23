module cpu_rom_ram(
    input CLK,
    input RESET_N,
    input[15:0] IO65_IN,
    output[15:0] IO64_OUT
);
    wire clk_ft;
    wire clk_dc;
    wire clk_ex;
    wire clk_wb;
    wire[7:0] p_count;
    wire[14:0] prom_out;
    wire[3:0] op_code;
    wire[7:0] op_data;
    wire[2:0] n_reg_a;
    wire[2:0] n_reg_b;
    wire[15:0] reg_in;
    wire[15:0] reg_a;
    wire[15:0] reg_b;
    wire reg_wen;
    wire[15:0] reg_0;
    wire[15:0] reg_1;
    wire[15:0] reg_2;
    wire[15:0] reg_3;
    wire[15:0] reg_4;
    wire[15:0] reg_5;
    wire[15:0] reg_6;
    wire[15:0] reg_7;
    wire[15:0] io65_in;
    wire[7:0] ram_addr;
    wire[15:0] ram_in;
    wire[15:0] ram_out;
    wire ram_wen;
    wire[15:0] ram_0;
    wire[15:0] ram_1;
    wire[15:0] ram_2;
    wire[15:0] ram_3;
    wire[15:0] ram_4;
    wire[15:0] ram_5;
    wire[15:0] ram_6;
    wire[15:0] ram_7;
    wire[15:0] io64_out;

    clk_gen C1(
        .CLK(CLK),
        .CLK_FT(clk_ft),
        .CLK_DC(clk_dc),
        .CLK_EX(clk_ex),
        .CLK_WB(clk_wb)
    );

    fetch_rom C2(
	     .address(p_count),
        .clock(clk_ft),
        .q(prom_out)
    );

    decode C3(
        .CLK_DC(clk_dc),
        .PROM_OUT(prom_out),
        .OP_CODE(op_code),
        .OP_DATA(op_data)
    );

    reg_dc C4(
        .CLK_DC(clk_dc),
        .N_REG_IN(prom_out[10:8]),
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7),
        .N_REG_OUT(n_reg_a),
        .REG_OUT(reg_a)
    );

    reg_dc C5(
        .CLK_DC(clk_dc),
        .N_REG_IN(prom_out[7:5]),
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7),
        .N_REG_OUT(n_reg_b),
        .REG_OUT(reg_b)
    );

    exec C6(
        .CLK_EX(clk_ex),
        .RESET_N(RESET_N),
        .OP_CODE(op_code),
        .REG_A(reg_a),
        .REG_B(reg_b),
        .OP_DATA(op_data),
        .RAM_OUT(ram_out),
        .P_COUNT(p_count),
        .REG_IN(reg_in),
        .RAM_IN(ram_in),
        .REG_WEN(reg_wen),
        .RAM_WEN(ram_wen)
    );

    reg_wb C7(
        .CLK_WB(clk_wb),
        .RESET_N(RESET_N),
        .N_REG(n_reg_a),
        .REG_IN(reg_in),
        .REG_WEN(reg_wen),
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7)
    );

    ram_dc_wb C8(
        .CLK_DC(clk_dc),
        .CLK_WB(clk_wb),
        .RAM_ADDR(prom_out[7:0]),
        .RAM_IN(ram_in),
        .IO65_IN(io65_in),
        .RAM_WEN(ram_wen),
        .RAM_OUT(ram_out),
        .IO64_OUT(io64_out)
    );

	 assign io65_in = IO65_IN & 16'b0000001111111111;
    assign IO64_OUT = io64_out ^ 16'b1111110000000000;
endmodule


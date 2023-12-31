module reg_wb(
    input CLK_WB,
    input RESET_N,
    input[2:0] N_REG,
    input[15:0] REG_IN,
    input REG_WEN,
    output reg[15:0] REG_0,
    output reg[15:0] REG_1,
    output reg[15:0] REG_2,
    output reg[15:0] REG_3,
    output reg[15:0] REG_4,
    output reg[15:0] REG_5,
    output reg[15:0] REG_6,
    output reg[15:0] REG_7
);

    always @(posedge CLK_WB) begin
        if (RESET_N == 0) begin
            REG_0 <= 16'b0;
            REG_1 <= 16'b0;
            REG_2 <= 16'b0;
            REG_3 <= 16'b0;
            REG_4 <= 16'b0;
            REG_5 <= 16'b0;
            REG_6 <= 16'b0;
            REG_7 <= 16'b0;
        end
        else if (REG_WEN == 1) begin
            case (N_REG)
                3'b000: REG_0 <= REG_IN;
                3'b001: REG_1 <= REG_IN;
                3'b010: REG_2 <= REG_IN;
                3'b011: REG_3 <= REG_IN;
                3'b100: REG_4 <= REG_IN;
                3'b101: REG_5 <= REG_IN;
                3'b110: REG_6 <= REG_IN;
                3'b111: REG_7 <= REG_IN;
                default: ;// nothing to do
            endcase
        end
    end
endmodule

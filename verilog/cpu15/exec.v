module exec(
    input CLK_EX,
    input RESET_N,
    input[3:0] OP_CODE,
    input[15:0] REG_A,
    input[15:0] REG_B,
    input[7:0] OP_DATA,
    input[15:0] RAM_OUT,
    output reg[7:0]	P_COUNT,
    output reg[15:0] REG_IN,
    output reg[15:0] RAM_IN,
    output reg REG_WEN,
    output reg RAM_WEN
);
    reg cmp_flag = 0;

    always @(posedge CLK_EX) begin
        if (RESET_N == 0) begin
            P_COUNT <= 0;
            cmp_flag <= 0;
        end
        else begin
            case (OP_CODE)
                4'b0000: // MOV
                begin
                    REG_IN <= REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0001: // ADD
                begin
                    REG_IN <= REG_A + REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0010: // SUB
                begin
                    REG_IN <= REG_A - REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0011: // AND
                begin
                    REG_IN <= REG_A & REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0100: // OR
                begin
                    REG_IN <= REG_A | REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0101: // SL
                begin
                    REG_IN <= {REG_A[14:0], 1'b0};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0110: // SR
                begin
                    REG_IN <= {1'b0, REG_A[15:1]};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b0111: // SRA
                begin
                    REG_IN <= {REG_A[15], REG_A[15:1]};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b1000: // LDL
                begin
                    REG_IN <= {REG_A[15:8], OP_DATA};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b1001: // LDH
                begin
                    REG_IN <= {OP_DATA, REG_A[7:0]};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b1010: // CMP
                begin
                    if (REG_A == REG_B) begin
                        cmp_flag <= 1;
                    end
                    else begin
                        cmp_flag <= 0;
                    end
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b1011: // JE
                begin
                    if (cmp_flag == 1) begin
                        P_COUNT <= OP_DATA;
                    end
                    else begin
                        P_COUNT <= P_COUNT + 1;
                    end
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                end
                4'b1100: // JMP
                begin
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                    P_COUNT <= OP_DATA;
                end
                4'b1101: // LD
                begin
                    REG_IN <= RAM_OUT;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b1110: // ST
                begin
                    RAM_IN <= REG_A;
                    REG_WEN <= 0;
                    RAM_WEN <= 1;
                    P_COUNT <= P_COUNT + 1;
                end
                4'b1111: // HLT
                begin
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                end
                default: ;// nothing to do
            endcase
        end
    end
endmodule

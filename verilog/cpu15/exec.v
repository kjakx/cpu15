module exec(
	input CLK_EX,
	input RESET_N,
	input[3:0] OP_CODE,
	input[15:0] REG_A,
	input[15:0] REG_B,
	input[7:0] OP_DATA,
	input[15:0] RAM_OUT,
	output[7:0]	P_COUNT,
	output[15:0] REG_IN,
	output[15:0] RAM_IN,
	output REG_WEN,
	output RAM_WEN
);
	reg[7:0] pc = 0;
	reg cmp_flag = 0;
	reg[15:0] REG_IN;
	reg[15:0] RAM_IN;
	reg REG_WEN;
	reg RAM_WEN;

	always @(posedge CLK_EX) begin
		if (RESET_N == 0) begin
			pc <= 0;
			cmp_flag <= 0;
		end
		else begin
			case (OP_CODE)
				0000: // MOV
				begin
					REG_IN <= REG_B;
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0001: // ADD
				begin
					REG_IN <= REG_A + REG_B;
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0010: // SUB
				begin
					REG_IN <= REG_A - REG_B;
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0011: // AND
				begin
					REG_IN <= REG_A & REG_B;
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0100: // OR
				begin
					REG_IN <= REG_A | REG_B;
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0101: // SL
				begin
					REG_IN <= {REG_A[14:0], 1'b0};
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0110: // SR
				begin
					REG_IN <= {1'b0, REG_A[15:1]};
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				0111: // SRA
				begin
					REG_IN <= {REG_A[15], REG_A[15:1]};
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				1000: // LDL
				begin
					REG_IN <= {REG_A[15:8], OP_DATA};
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				1001: // LDH
				begin
					REG_IN <= {OP_DATA, REG_A[7:0]};
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				1010: // CMP
				begin
					if (REG_A == REG_B) begin
						cmp_flag <= 1;
					end
					else begin
						cmp_flag <= 0;
					end
					REG_WEN <= 0;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				1011: // JE
				begin
					if (cmp_flag == 1) begin
						pc <= OP_DATA;
					end
					else begin
						pc <= pc + 1;
					end
					REG_WEN <= 0;
					RAM_WEN <= 0;
				end
				1100: // JMP
				begin
					REG_WEN <= 0;
					RAM_WEN <= 0;
					pc <= OP_DATA;
				end
				1101: // LD
				begin
					REG_IN <= RAM_OUT;
					REG_WEN <= 1;
					RAM_WEN <= 0;
					pc <= pc + 1;
				end
				1110: // ST
				begin
					RAM_IN <= REG_A;
					REG_WEN <= 0;
					RAM_WEN <= 1;
					pc <= pc + 1;
				end
				1111: // HLT
				begin
					REG_WEN <= 0;
					RAM_WEN <= 0;
				end
				default: ;// nothing to do
			endcase
		end
	end

	assign P_COUNT = pc;
endmodule



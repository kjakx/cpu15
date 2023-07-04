module adder_4bit_lib(A, B, S);
	input[3:0] A, B;
	output[4:0] S;
	assign S = A + B;
endmodule

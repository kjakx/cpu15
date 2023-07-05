module and_or(A, B, Z_AND, Z_OR);
	input A, B;
	output Z_AND, Z_OR;

	assign Z_AND = A & B;
	assign Z_OR = A | B;
endmodule

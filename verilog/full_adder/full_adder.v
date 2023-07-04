module full_adder(A, B, CI, S, CO);
	input A, B, CI;
	output S, CO;
	wire s_tmp, c1, c2;

	half_adder ha1(A, B, s_tmp, c1);
	half_adder ha2(s_tmp, CI, S, c2);
	assign CO = c1 | c2;
endmodule

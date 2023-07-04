module adder_4bit(A, B, S);
	input[3:0] A, B;
	output[4:0] S;
	wire co_tmp0, co_tmp1, co_tmp2;
	half_adder C1(A[0], B[0], S[0], co_tmp0);
	full_adder C2(A[1], B[1], co_tmp0, S[1], co_tmp1);
	full_adder C3(A[2], B[2], co_tmp1, S[2], co_tmp2);
	full_adder C4(A[3], B[3], co_tmp2, S[3], S[4]);
endmodule

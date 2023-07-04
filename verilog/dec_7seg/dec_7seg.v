module dec_7seg(DIN, SEG7);
	input[3:0] DIN;
	output[6:0] SEG7;
	
	function[6:0] dec;
		input[3:0] din;
		case (din)
			4'h0: dec = 7'b1000000;
			4'h1: dec = 7'b1111001;
			4'h2: dec = 7'b0100100;
			4'h3: dec = 7'b0110000;
			4'h4: dec = 7'b0011001;
			4'h5: dec = 7'b0010010;
			4'h6: dec = 7'b0000010;
			4'h7: dec = 7'b1111000;
			4'h8: dec = 7'b0000000;
			4'h9: dec = 7'b0010000;
			default: dec = 7'bxxxxxxx;	
		endcase
	endfunction

	assign SEG7 = dec(DIN);
endmodule

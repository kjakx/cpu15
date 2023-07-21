module fetch_rom_timequest(
	input[7:0] addr,
	input clk,
	output reg[14:0] q2
);
	wire[14:0] q_internal;
	
	fetch_rom C1(
		.address(addr),
		.clock(clk),
		.q(q_internal)
	);
	
	always @(posedge clk) begin
		q2 <= q_internal;
	end
endmodule
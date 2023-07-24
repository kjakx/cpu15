module ram_1port_timequest(
	input[7:0] addr,
	input clk,
	input[15:0] data,
	input wren,
	output reg[15:0] q2
);
	wire[15:0] q_internal;
	
	ram_1port C1(
		.address(addr),
		.clock(clk),
		.data(data),
		.wren(wren),
		.q(q_internal)
	);
	
	always @(posedge clk) begin
		q2 <= q_internal;
	end
endmodule
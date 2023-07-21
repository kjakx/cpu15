`timescale 1ps/1ps

module fetch_rom_sim(
    output[7:0] addr_out,
	 output clk_out,
	 output [14:0] q_out
);
    reg[7:0] addr = 8'b0; 
    reg clk = 1'b0;
	 wire[14:0] q;
    integer i = 0;

    fetch_rom C1(
        .address(addr),
        .clock(clk),
        .q(q)
    );

    parameter T = 20000;
    
    always #(T/2)
        clk = ~clk;

    initial begin
        for (i = 0; i < 16; i = i+1)
            #(T) addr <= addr + 1;
        $finish;
    end
	 
	 assign addr_out = addr;
	 assign clk_out = clk;
	 assign q_out = q;
endmodule
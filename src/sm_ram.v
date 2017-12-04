// Quartus II Verilog Template
// True Dual Port RAM with single clock

module dataRAMModule
#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 4)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output [(DATA_WIDTH-1):0] q_a, q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
    assign q_a = ram[addr_a];
    assign q_b = ram[addr_b];
    
	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_a;
		end
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] <= data_b;
		end 
	end

    initial begin
        $readmemh ("ramDATA.hex", ram);
    end
endmodule

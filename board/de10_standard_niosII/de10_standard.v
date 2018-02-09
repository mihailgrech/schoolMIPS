module de10_standard
(
    input                       CLOCK2_50,
    input                       CLOCK3_50,
    input                       CLOCK4_50,
    input                       CLOCK_50,

    input            [3:0]      KEY,

    input            [9:0]      SW,

    output           [9:0]      LEDR,

    output           [6:0]      HEX0,
    output           [6:0]      HEX1,
    output           [6:0]      HEX2,
    output           [6:0]      HEX3,
    output           [6:0]      HEX4,
    output           [6:0]      HEX5
);

    // wires & inputs
    wire          clk;
    wire          clkIn     =  CLOCK_50;
    wire          rst_n     =  KEY[0];

	wire [ 31:0 ] h7segment;    
	nios_system NIOSII
	(
		.clk_clk		 ( clkIn     ),
		.leds_export     ( LEDR[7:0] ),
		.reset_reset_n   ( rst_n     ),
		.switches_export ( SW[7:0]   ),
		.to_hex_readdata ( h7segment ),
	);
	
	hex7segmentModule h0 (h7segment[3:0],   HEX0);
	hex7segmentModule h1 (h7segment[7:4],   HEX1);
	hex7segmentModule h2 (h7segment[11:8],  HEX2);
	hex7segmentModule h3 (h7segment[15:12], HEX3);
		
endmodule

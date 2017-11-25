module marsohod_2_top(		  
      input       CLK100MHZ,
      input       KEY0,
      input       KEY1,
		
      inout    [13:0] GPIO0_D,        //    GPIO Connection 0 Data Bus
      inout    [13:0] GPIO1_D,        //    GPIO Connection 1 Data Bus
		
      output   [3:0]  LED,
      output   [6:0]  HEX0_D,         //    Seven Segment Digit 0
      output          HEX0_DP,        //    Seven Segment Digit DP 0
      output   [6:0]  HEX1_D,         //    Seven Segment Digit 1
      output          HEX1_DP,        //    Seven Segment Digit DP 1
      output   [6:0]  HEX2_D,         //    Seven Segment Digit 2
      output          HEX2_DP         //    Seven Segment Digit DP 2
);

    // wires & inputs
    wire          clk;
    wire          clkIn     =  CLK100MHZ;
    wire          rst_n     =  KEY0;
    wire [7:0]    extraInput;
    wire          clkEnable =  ~KEY1;
    wire [31:0]   regData;

    // cores
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
		  .extraInput ( extraInput ),
        .clkDevide  ( 4'b0010   ),
        .clkEnable  ( clkEnable ),
        .clk        ( clk       ),
        .regAddr    ( 4'b0010   ),
        .regData    ( regData   )
    );
	 
	 // dip switcher
	 assign extraInput = {2'b00, GPIO1_D[12:7] };
	 
	 // led indicators
    assign LED[3:0] = regData[3:0];
	 
	 // 7 segment indicator
	 wire [31:0] h7segment = regData; // display it on a seven segment indicator
	 wire [11:0] seven_segments; // 12 bit to control segments of the indicator

	 // get 7bit number for the indicator
	 sm_hex_display digit_1 ( h7segment [ 3: 0] , HEX0_D [6:0] );
	 sm_hex_display digit_2 ( h7segment [ 7: 4] , HEX1_D [6:0] );
	 sm_hex_display digit_3 ( h7segment [11: 8] , HEX2_D [6:0] );
	 
	 // we can display only 1 digit at the same time, so let's blink
	 sm_hex_display_blink sm_hex_display_blink
	 (
			.digit1 (HEX0_D),
			.digit2 (HEX1_D),
			.digit3 (HEX2_D),
			.clkIn  (clkIn ),
			.seven_segments (seven_segments)
	 );
	 	 	 
	 assign GPIO0_D[5]  = seven_segments[10]; // a
	 assign GPIO0_D[6]  = seven_segments[9];  // f
	 assign GPIO0_D[7]  = seven_segments[6];  // b
	 assign GPIO0_D[8]  = seven_segments[4];  // g
	 assign GPIO0_D[9]  = seven_segments[3];  // c
	 assign GPIO0_D[10] = seven_segments[1];  // d
	 assign GPIO0_D[11] = seven_segments[0];  // e
	 
	 assign GPIO0_D[12] = seven_segments[11];
	 assign GPIO1_D[5]  = seven_segments[8];
	 assign GPIO1_D[6]  = seven_segments[7];	 
endmodule

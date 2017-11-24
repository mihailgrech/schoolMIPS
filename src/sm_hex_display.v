
module sm_hex_display
(
    input      [3:0] digit,
    output reg [6:0] seven_segments
);
    // BC56-12GWA 7-digit indicator
    always @*
        case (digit)
        'h0: seven_segments = 'b0111111;  // g f e d c b a
        'h1: seven_segments = 'b0000110;  // 
        'h2: seven_segments = 'b1011011;  //   --a--
        'h3: seven_segments = 'b1001111;  //  |     |
        'h4: seven_segments = 'b1100110;  //  f     b
        'h5: seven_segments = 'b1101101;  //  |     |
        'h6: seven_segments = 'b1111101;  //   --g--
        'h7: seven_segments = 'b0000111;  //  |     |
        'h8: seven_segments = 'b1111111;  //  e     c
        'h9: seven_segments = 'b1100111;  //  |     |
        'ha: seven_segments = 'b1110111;  //   --d-- 
        'hb: seven_segments = 'b1111100;
        'hc: seven_segments = 'b0111001;
        'hd: seven_segments = 'b1011110;
        'he: seven_segments = 'b1111001;
        'hf: seven_segments = 'b1110001;
        endcase
endmodule

module sm_hex_display_blink
(
    input [6:0] digit1,
    input [6:0] digit2,
    input [6:0] digit3,
    input       clkIn, // wire to clk100 or smth else
    output reg [11:0] seven_segments
);

    reg [9:0] count = 10'b0000000000;
    
    always @(posedge clkIn)
    begin
        case (count [9:8])
            2'b00: seven_segments = { 1'b0, digit1[0], digit1[5], 2'b11, digit1[1], 1'b1, digit1[6], digit1[2], 1'b0, digit1[3], digit1[4] };
            2'b01: seven_segments = { 1'b1, digit2[0], digit2[5], 2'b01, digit2[1], 1'b1, digit2[6], digit2[2], 1'b0, digit2[3], digit2[4] };
            2'b10: seven_segments = { 1'b1, digit3[0], digit3[5], 2'b10, digit3[1], 1'b1, digit3[6], digit3[2], 1'b0, digit3[3], digit3[4] };
            default: count <= count + 1'b0;
        endcase
        
        count <= count + 1'b1;
    end
endmodule
    
//--------------------------------------------------------------------

module sm_hex_display_8
(
    input             clock,
    input             resetn,
    input      [31:0] number,

    output reg [ 6:0] seven_segments,
    output reg        dot,
    output reg [ 7:0] anodes
);

    function [6:0] bcd_to_seg (input [3:0] bcd);

        case (bcd)
        'h0: bcd_to_seg = 'b1000000;  // a b c d e f g
        'h1: bcd_to_seg = 'b1111001;
        'h2: bcd_to_seg = 'b0100100;  //   --a--
        'h3: bcd_to_seg = 'b0110000;  //  |     |
        'h4: bcd_to_seg = 'b0011001;  //  f     b
        'h5: bcd_to_seg = 'b0010010;  //  |     |
        'h6: bcd_to_seg = 'b0000010;  //   --g--
        'h7: bcd_to_seg = 'b1111000;  //  |     |
        'h8: bcd_to_seg = 'b0000000;  //  e     c
        'h9: bcd_to_seg = 'b0011000;  //  |     |
        'ha: bcd_to_seg = 'b0001000;  //   --d-- 
        'hb: bcd_to_seg = 'b0000011;
        'hc: bcd_to_seg = 'b1000110;
        'hd: bcd_to_seg = 'b0100001;
        'he: bcd_to_seg = 'b0000110;
        'hf: bcd_to_seg = 'b0001110;
        endcase

    endfunction

    reg [2:0] i;

    always @ (posedge clock or negedge resetn)
    begin
        if (! resetn)
        begin
            seven_segments <=   bcd_to_seg (0);
            dot            <= ~ 0;
            anodes         <= ~ 8'b00000001;

            i <= 0;
        end
        else
        begin
            seven_segments <=   bcd_to_seg (number [i * 4 +: 4]);
            dot            <= ~ 0;
            anodes         <= ~ (1 << i);

            i <= i + 1;
        end
    end

endmodule
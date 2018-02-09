module hex7segmentModule (hex, display);
    input [3:0] hex;
    output [0:6] display;
    reg [0:6] display;
    /*
    * – 0 –
    * 5 | | 1
    * – 6 –
    * 4 | | 2
    * – 3 –
    */
    always @ (hex)
        case (hex)
            4'h0: display = 8'b1000000;  // a b c d e f g
            4'h1: display = 8'b1111001;
            4'h2: display = 8'b0100100;  //   --a--
            4'h3: display = 8'b0110000;  //  |     |
            4'h4: display = 8'b0011001;  //  f     b
            4'h5: display = 8'b0010010;  //  |     |
            4'h6: display = 8'b0000010;  //   --g--
            4'h7: display = 8'b1111000;  //  |     |
            4'h8: display = 8'b0000000;  //  e     c
            4'h9: display = 8'b0011000;  //  |     |
            4'ha: display = 8'b0001000;  //   --d-- 
            4'hb: display = 8'b0000011;
            4'hc: display = 8'b1000110;
            4'hd: display = 8'b0100001;
            4'he: display = 8'b0000110;
            4'hf: display = 8'b0001110;
        endcase
endmodule

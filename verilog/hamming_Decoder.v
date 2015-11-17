/*
 * @INPUT: In this part of the verilog file, we try to implement
 * the hamming (8,4) encoder. The input is 4-bits
 * @OUPUT: The output is 8 bits.
 */
  module hamm_decoder(
    input [7:0] out,
    output reg [3:0] in,
    input clk,
    input reset);
    
    always@(posedge clk or negedge reset)
    begin
		case (out)
			8'b00000000: in = 4'd0;
			8'b00010111: in = 4'd1; 
			8'b00101011: in = 4'd2;
			8'b00111100: in = 4'd3;
			8'b01001101: in = 4'd4;
			8'b01011010: in = 4'd5;
			8'b01100110: in = 4'd6;
			8'b01110001: in = 4'd7;
			8'b10001110: in = 4'd8;
			8'b10011001: in = 4'd9;
			8'b10100101: in = 4'd10;
			8'b10110010: in = 4'd11;
			8'b11000011: in = 4'd12;
			8'b11010101: in = 4'd13;
			8'b11101000: in = 4'd14;
			8'b11111110: in = 4'd15;
			default: in = 4'd0;
		endcase
    end
endmodule
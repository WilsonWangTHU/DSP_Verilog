/*
 * @INPUT: In this part of the verilog file, we try to implement
 * the hamming (8,4) encoder. The input is 4-bits
 * @OUPUT: The output is 8 bits.
 */
  module hamm_encoder(
    output reg [7:0] out,
    input [3:0] in,
    input clk,
    input reset);
    
    always@(posedge clk or negedge reset)
    begin
		case (in)
			4'd0: out = 8'b00000000;
			4'd1: out = 8'b00010111;
			4'd2: out = 8'b00101011;
			4'd3: out = 8'b00111100;
			4'd4: out = 8'b01001101;
			4'd5: out = 8'b01011010;
			4'd6: out = 8'b01100110;
			4'd7: out = 8'b01110001;
			4'd8: out = 8'b10001110;
			4'd9: out = 8'b10011001;
			4'd10: out = 8'b10100101;
			4'd11: out = 8'b10110010;
			4'd12: out = 8'b11000011;
			4'd13: out = 8'b11010101;
			4'd14: out = 8'b11101000;
			4'd15: out = 8'b11111110;
			default: out = 8'b11110000;
		endcase
    end
  endmodule
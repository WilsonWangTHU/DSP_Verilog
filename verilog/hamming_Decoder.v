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
    
    wire [2:0] s;
    reg [7:0] mask;
    
    assign s[0] = out[7]^out[6]^out[5]^out[3];
    assign s[1] = out[7]^out[6]^out[4]^out[2];
    assign s[2] = out[7]^out[5]^out[4]^out[1];
    /*
    assign s[0] = out[0]^out[1]^out[2]^out[4];
    assign s[1] = out[0]^out[1]^out[3]^out[5];
    assign s[2] = out[0]^out[2]^out[3]^out[6];
    */
    always@(posedge clk or negedge reset)
    begin
		case (s)
		  3'd0: mask = 7'b0000000;
		  3'd1: mask = 7'b0000001;
		  3'd2: mask = 7'b0000010;
		  3'd3: mask = 7'b0000100;
		  3'd4: mask = 7'b0001000;
		  3'd5: mask = 7'b0010000;
		  3'd6: mask = 7'b0100000;
		  3'd7: mask = 7'b1000000;
			default: mask = 7'b0000000;
		endcase
    end
    
    always@(posedge clk or negedge reset)
    begin
      in[0] = mask[4] + out[4];
      in[1] = mask[5] + out[5];
      in[2] = mask[6] + out[6];
      in[3] = mask[7] + out[7];
    end
    
    
endmodule
/***************************************************************************
 * @Author: Created by Tingwu Wang, 01/11/2015.
 *
 * @Brief: In this module, we implement the ask modulation and demodulation. 
 * Note that in this module, the task are two parts. In the first part, We 
 * send the signal. 
 * The original signal is 4-bits, controlled by the buttoms on the fpga. It
 * is then transmitted into a 8-bits hamming code and sent into the D/A.
 * Then the analog signal goes through the A/D and back into a 8-bits signal. 
 * At last, the 8 bits are decoded back to the original 4 bits code. 
 *
 * @INPUT: 
 *     "[3:0] origin" is the original code to be sent, bounded to the 4 
 * buttoms on the fpga. 
 *     "[7:0] received" is the analog signal from the D/A.
 * 
 * @OUPUT: 
 *     "[7:0] led_1" shows the received hamming code. It is equal to the 
 *[7:0] received.  
 *     "[7:0] led_2" shows the decoded results in the first 4 digit [3:0],
 * and the original signal in the last 4 digit
 ***************************************************************************/
 
module CommModem(
  /*	System IO			*/
  input [3:0] origin,
  input [7:0] received,  /* bounded to the AD */
  input sys_clk,
  input reset,
  input [3:0] error,
  output wire [7:0] sent,  /* bounded to the DA */
  output wire [7:0] led_1,		/*	1st row of leds 	*/
  output wire [7:0] led_2,		/* 2nd row of leds 	*/
  output wire WRT1,
  output wire WRT2,
  output wire ENCA,
  output wire ENCB
  );
  
  assign WRT1 = sys_clk;
  assign WRT2 = sys_clk;
  assign ENCA = sys_clk;
  assign ENCB = sys_clk;
  
  wire [3:0] decoded_results;
  reg [7:0]	led_1_reg, led_2_reg;  /* this two variables are for debug purposes 
                                      and will be used as the */
  
  
  assign led_2[3:0] = decoded_results;  /* the output results */
  assign led_2[7:4] = origin;           /* the original input */
  assign led_1 = received;
  
  
  
  
  wire clk_1, clk_2, clk_4, clk_8, clk_16, clk_32;
  wire clk_64, clk_128, clk_256, clk_512, clk_30, clk_8k, clk_slow;
  
  
  ClkGen cg(
    .sys_clk	(	sys_clk	),
    .reset		(	reset		),
    .clk_1		(	clk_1		),
    .clk_2		(	clk_2		),
	  .clk_4		(	clk_4		),
	  .clk_8		(	clk_8		),
	  .clk_16		(	clk_16	),
	  .clk_32		(	clk_32	),
	  .clk_64		(	clk_64	),
	  .clk_128	(	clk_128	),
	  .clk_256	(	clk_256	),
	  .clk_512	(	clk_512	),
	  .clk_30		(	clk_30	),
	  .clk_8k		(	clk_8k	),
	  .clk_slow  (  clk_slow )
  );
  
  /*
  
  If we don't use the ad da part
  
  */
  
  //wire [7:0] received;
  reg [3:0] temp_received;
  //assign received[7:4] = sent[7:4];
  //assign received[3:0] = temp_received[3:0];
  
  always @(posedge clk_slow or negedge reset)
  begin
		if (!reset) begin
			temp_received[0] <= 1'b0;
			temp_received[1] <= 1'b0;
			temp_received[2] <= 1'b0;
			temp_received[3] <= 1'b0;
		end
		else begin
			temp_received[0] <= sent[0] + error[0];
			temp_received[1] <= sent[1] + error[1];
			temp_received[2] <= sent[2] + error[2];
			temp_received[3] <= sent[3] + error[3];
		end
  end
  
  /*
  */
  
  hamm_encoder test_encoder2(
    .out(sent),
    .in(origin),
    .clk(sys_clk),
    .reset(reset));
  
  hamm_decoder test_decoder2(
    .out(received),
    .in(decoded_results),
    .clk(sys_clk),
    .reset(reset));
  
  /* 
   * Generate led show
   */
  always @(posedge clk_slow or negedge reset)
  begin
		if (!reset) begin
			led_1_reg <= 8'd0;
			led_2_reg <= 8'd0;
		end
		else begin
			led_1_reg <= led_1_reg + 8'd1;
			led_2_reg <= led_2_reg + 8'd1;
		end
  end

endmodule

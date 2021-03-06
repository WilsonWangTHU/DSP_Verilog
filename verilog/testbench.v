`timescale 1ns/1ns

module test_encode_decode;

reg sys_clk;
reg reset;

reg [3:0] test_input;
wire [7:0] sim_enocde_output;

wire [3:0] decoded_results;

wire [7:0] debugled1;
wire [7:0] debugled2;
wire [7:0] module_enocde_output;

CommModem testComm(
  /*	System IO			*/
  .origin(test_input),
  .received(sim_enocde_output),
  .sys_clk(sys_clk),
  .reset(reset),
  .sent(module_enocde_output),
  .led_1(debugled1),		/*	1st row of leds 	*/
  .led_2(debugled2)		/* 2nd row of leds 	*/
  );
assign decoded_results = debugled2[3:0];
hamm_encoder test_encoder(
  .out(sim_enocde_output),
  .in(test_input),
  .clk(sys_clk),
  .reset(reset));
  
initial
begin
       test_input = 0;
       sys_clk = 1'b0;
       reset = 1'b1;
       #10
       reset = 0'b0;
       #10
       #500
       reset = 1'b1;
end

always
begin
  #10
  sys_clk = ~sys_clk;
end 

always
begin
  #100
  test_input = test_input + 1;
end 
 
endmodule
`timescale 1ns/1ns

module test_ask;

reg sys_clk;
reg reset;
reg [7:0] DA;
wire [7:0] DB;
wire [7:0] led_1;		/*	1st row of leds 	*/
wire [7:0] led_2;		/* 2nd row of leds 	*/

CommModem myCom(
  /*	System IO			*/
  .sys_clk(sys_clk),
  .reset(reset),
  .DA(DA),
  .DB(DB),
  .led_1(led_1),		/*	1st row of leds 	*/
  .led_2(led_2)		/* 2nd row of leds 	*/
  );
  
 
initial
begin
       sys_clk = 1'b0;
       reset = 1'b1;
       DA = 8'b00000000;
       #10
       reset = 0'b0;
       #10
       DA = 8'b01100000;
       #500
       reset = 1'b1;
end

always
begin
  #10
  sys_clk = ~sys_clk;
end 
 
endmodule
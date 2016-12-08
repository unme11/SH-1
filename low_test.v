`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:24:23 11/23/2016 
// Design Name: 
// Module Name:    low_test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module low_test(signal_in,signal_out,time_constant,clk,reset,enable,data,sine//,signal_out_tmp
    );
input clk;
input reset;
input enable;
input[27:0] signal_in;	 
output[27:0] signal_out;	
input[4:0] time_constant;
input [31:0] data;
output[13:0] sine;
//output[39:0] signal_out_tmp;
 wire[27:0] signal_out_1;	
  reg signed[27:0] signal_out_2;	
    wire[27:0] signal_out_3;	
lowp5 l1(.signal_in(signal_in),
.signal_out(signal_out), //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
.time_constant(time_constant),
.clock_in(clk),
.reset(reset),
.enable(enable)//,
//.signal_out_tmp(signal_out_tmp)
);
//always@(posedge clk)
//begin
//	signal_out_2<=signal_out_1;
//end
//lowp l2(.signal_in(signal_out_2),
//.signal_out(signal_out), //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
//.time_constant(time_constant),
//.clock_in(clk),
//.reset(reset),
//.enable(enable)//,
////.signal_out_tmp(signal_out_tmp)
//);



//lowp l3(.signal_in(signal_out_2),
//.signal_out(signal_out_3), //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
//.time_constant(time_constant),
//.clock_in(clk),
//.reset(reset),
//.enable(enable)//,
////.signal_out_tmp(signal_out_tmp)
//);
//lowp l4(.signal_in(signal_out_3),
//.signal_out(signal_out), //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
//.time_constant(time_constant),
//.clock_in(clk),
//.reset(reset),
//.enable(enable)//,
////.signal_out_tmp(signal_out_tmp)
//);

dgenerate d1 (
  .clk(clk), // input clk
  .we(1'b1), // input we
  .data(data), // input [31 : 0] data
  .sine(sine) // output [13 : 0] sine
);


endmodule

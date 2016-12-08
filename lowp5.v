`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    10:51:47 07/22/2013
// Design Name:
// Module Name:    lowp
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
module lowp5(signal_in,
                                signal_out, //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
										  time_constant,
                                clock_in,
                                reset,
										  enable);
parameter N=3;
input enable;
input   signed  [27:0]  signal_in;
integer i;
input   signed  [4:0]  time_constant;
input   clock_in;
input   reset;          //reset filter on reset high.

reg signed  [27:0]  signal_out_1 [0:N-1];
reg signed  [27:0]  signal_in_1 [0:N-1];
output signed  [27:0]  signal_out;
assign signal_out=signal_out_1[0];

wire signed [31:0] a1=1073741824;
wire signed [31:0] a2=2148224448;
wire signed [31:0] a3=1073001490;

wire signed [31:0] b1=104;
wire signed [31:0] b2=208;
wire signed [31:0] b3=104;


wire    signed  [59:0]  multiply_out;

assign  multiply_out = (b1*signal_in+b2*signal_in_1[0]+b3*signal_in_1[1])-(a2*signal_out_1[0]+a3*signal_out_1[1]);


always @ (posedge clock_in)
begin
    if(reset) //a synchrous reset is nice when you're using long time constants and want fast step scanning of some parameter while measureing.  It's not implemented here.
    begin
		  for (i = 0; i < N ; i = i + 1) begin
				signal_out_1[i] <= signal_in;
				signal_in_1[i] <= signal_in;
		  end
    end

    else if(enable)
    begin
	 signal_in_1[0]<=signal_in;
	 signal_out_1[0]<={multiply_out[59], multiply_out[56:30]};
		  for (i = 1; i < N ; i = i + 1) begin
				signal_out_1[i] <= signal_out_1[i-1];
				signal_in_1[i]  <= signal_in_1[i-1];
		  end
    end
end

endmodule




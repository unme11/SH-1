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
module lowp(signal_in,
                                signal_out, //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
										  time_constant,
                                clock_in,
                                reset,
										  enable);
parameter N=5;
input enable;
input   signed  [27:0]  signal_in;
integer i;
input   signed  [4:0]  time_constant;
input   clock_in;
input   reset;          //reset filter on reset high.

reg signed  [27:0]  signal_out_1 [0:N-1];
output signed  [27:0]  signal_out;
assign signal_out=signal_out_1[0];


wire    signed  [59:0]  multiply_out;

wire signed[27:0] diff=signal_in-signal_out_1[N-1];
wire signed [59:0] s=signal_out_1[N-1]<<30;
wire signed [59:0] d=diff<<time_constant;
assign  multiply_out = d+s;


always @ (posedge clock_in)
begin
    if(reset) //a synchrous reset is nice when you're using long time constants and want fast step scanning of some parameter while measureing.  It's not implemented here.
    begin
		  for (i = 0; i < N ; i = i + 1) begin
				signal_out_1[i] <= signal_in;
		  end
    end

    else if(enable)
    begin
        signal_out_1[0] <= {multiply_out[59], multiply_out[56:30]};
		  for (i = 1; i < N ; i = i + 1) begin
				signal_out_1[i] <= signal_out_1[i-1];
		  end
    end
end

endmodule




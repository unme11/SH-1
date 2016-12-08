`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:57:28 11/23/2016 
// Design Name: 
// Module Name:    lowp2 
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
module lowp2(signal_in,
                                signal_out, //time constant is actually parameter equal to e^-1/d where d is number of samples time constant
										  time_constant,
                                clock_in,
                                reset,
										  enable,
										  signal_out_tmp);

input enable;
input   signed  [27:0]  signal_in;
output   signed  [27:0]  signal_out;
input   signed  [4:0]  time_constant;
input   clock_in;
input   reset;          //reset filter on reset high.
integer z;

function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
parameter N=256;
parameter N2=log2(N)-1;
output reg signed [28+N2-1:0]  signal_out_tmp;

reg signed[27:0] data [0:N-1];
wire signed [28+N2-1:0] summation_steps [0:N-1];//container for all sumation steps
wire[28+N2-1:0] q=summation_steps[N-2];
genvar i;
generate
	 for (i = 0; i < N-1 ; i = i + 1) begin: gd
		 always @(posedge clock_in) begin
		 	if(reset==1'b1)
			begin
				data[i+1]<=0;
			end
			else
			begin
				data[i+1] <= data[i];
			end
		 end
    end
endgenerate
assign signal_out=q[27+N2:N2];
always @(posedge clock_in) begin
	if(reset==1'b1)
	begin
		data[0]<=0;
	end
	else
	begin
		data[0] <= signal_in;
	end
end

genvar c;
generate
	 assign summation_steps[0] = data[0] + data[1];
	 for (c = 0; c < N-2 ; c = c + 1) begin: gdz
		assign summation_steps[c+1] = summation_steps[c] + data[c+2];
    end
endgenerate

endmodule

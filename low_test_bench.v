`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:27:34 11/23/2016
// Design Name:   low_test
// Module Name:   D:/low_test/low_test_bench.v
// Project Name:  low_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: low_test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module low_test_bench;

	// Inputs
			
	reg [4:0] time_constant;
	reg clk;
	reg reset;
	reg enable;
	reg[31:0] data;

	// Outputs
	reg [27:0] signal_in;
	wire [27:0] signal_out;
	wire signed[13:0] sine;
	integer f;
	integer f2;
//	wire[39:0] signal_out_tmp;
wire signed [27:0] sine_2;
	// Instantiate the Unit Under Test (UUT)
	low_test uut (
		.signal_in(signal_in), 
		.signal_out(signal_out), 
		.time_constant(time_constant), 
		.clk(clk), 
		.reset(reset), 
		.enable(enable),
		.data(data),
		.sine(sine)//,
	//	.signal_out_tmp(signal_out_tmp)
	);
assign sine_2=sine*sine;
integer cur_time ;

	initial begin
		// Initialize Inputs
f = $fopen("output.txt","w");		
f2 = $fopen("time.txt","w");	
		signal_in = 0;
		time_constant = 22;
		data=727659*2;
		
		clk = 0;
		reset = 0;
		enable = 1'b1;

		// Wait 100 ns for global reset to finish
		#100;
		reset=1'b1;
		#1000;
		reset=1'b0;
//		#20000;
	//	signal_in = 28'hFFFFFF;
        
		// Add stimulus here

	end
	always
	begin
		#25; 
		clk=~clk;
		if(clk==1)
		begin
			signal_in=sine_2;
			cur_time = $time ;
			$fwrite(f,"%d %d\n",signal_in,signal_out);
			$fwrite(f2,"%d\n",cur_time);
		end
	end
	
	
      
endmodule


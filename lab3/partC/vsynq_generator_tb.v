`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:38:05 12/14/2020
// Design Name:   vsynq_generator
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment3/partC/vsynq_generator_tb.v
// Project Name:  partC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vsynq_generator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vsynq_generator_tb;

	// Inputs
	reg clk;
	reg reset;
	wire vsynq;
	wire vdisplay;

	// Instantiate the Unit Under Test (UUT)
	vsynq_generator uut (
		.clk(clk), 
		.reset(reset), 
		.vsynq(vsynq), 
		.vdisplay(vdisplay)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#10000;
      reset=1;
		
		// Add stimulus here
		#1000;
		reset=1'b0;
	end
	
	always
      #10 clk = ~clk;
      
endmodule


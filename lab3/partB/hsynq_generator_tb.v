`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:49:12 12/08/2020
// Design Name:   hsynq_generator
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment3/partB/hsynq_generator_tb.v
// Project Name:  partB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hsynq_generator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module hsynq_generator_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsynq,display;

	// Instantiate the Unit Under Test (UUT)
	hsynq_generator hsynq_generatorINSTANCE(
		.clk(clk), 
		.reset(reset), 
		.hsynq(hsynq),
		.display(display)
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


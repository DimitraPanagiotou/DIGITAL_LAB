`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:58:51 12/17/2020
// Design Name:   hsynq_generator
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/ass3_partc/hsynq_generator_tb.v
// Project Name:  ass3_partc
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
	wire hsynq;
	wire display;

	// Instantiate the Unit Under Test (UUT)
	hsynq_generator uut (
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
		#100;
      reset =1;
		
		// Add stimulus here
		#1000;
      reset =0;
		
		
		
	end
   
	always 
	#10 clk=~clk;
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:07:06 10/28/2020
// Design Name:   debouncer
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partC/debouncer_tb.v
// Project Name:  partC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debouncer_tb;

	// Inputs
	reg rst;
	reg clk;
	reg noise;

	// Outputs
	wire clean;

	// Instantiate the Unit Under Test (UUT)
	debouncer uut (
		.rst(rst), 
		.clk(clk), 
		.noise(noise), 
		.clean(clean)
	);
	integer i=0;
	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;
		noise = 0;

		// Wait 100 ns for global reset to finish
		#10 rst = 1;
		
		#10 rst=0;
      noise = 1;

		#5000010 noise = 0;
		
	end
	always
		#5 clk = ~clk;
		
      
endmodule


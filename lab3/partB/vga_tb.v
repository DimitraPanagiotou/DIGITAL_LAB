`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:26:32 12/09/2020
// Design Name:   vga
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment3/partB/vga_tb.v
// Project Name:  partB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire red;
	wire green;
	wire blue;

	// Instantiate the Unit Under Test (UUT)
	vga uut (
		.clk(clk), 
		.reset(reset), 
		.red(red), 
		.green(green), 
		.blue(blue)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1'b1;
		// Add stimulus here
	
		#1000;
		reset = 1'b0;
	end
		
	always
	#10 clk = ~clk;
	
endmodule


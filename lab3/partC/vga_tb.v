`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:03:54 12/16/2020
// Design Name:   vga
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/ass3_partc/vga_tb.v
// Project Name:  ass3_partc
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
	wire RED;
	wire GREEN;
	wire BLUE;
	wire HSYNQ;
	wire VSYNQ;

	// Instantiate the Unit Under Test (UUT)
	vga uut (
		.clk(clk), 
		.reset(reset), 
		.RED(RED), 
		.GREEN(GREEN), 
		.BLUE(BLUE), 
		.HSYNQ(HSYNQ), 
		.VSYNQ(VSYNQ)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;  
		// Add stimulus here
		#1000;
      reset = 0;  
		
	end
	always
		#10 clk = ~clk;
      
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:36:38 10/31/2020
// Design Name:   FourDigitLEDdriver
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partD/FourDigitLEDdriver_tb.v
// Project Name:  partD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FourDigitLEDdriver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FourDigitLEDdriver_tb;

	// Inputs
	reg rst;
	reg clk;

	// Outputs
	wire an3;
	wire an2;
	wire an1;
	wire an0;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
	wire dp;

	// Instantiate the Unit Under Test (UUT)
	FourDigitLEDdriver uut (
		.reset(rst), 
		.clk(clk), 
		.an3(an3), 
		.an2(an2), 
		.an1(an1), 
		.an0(an0), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.dp(dp)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#500;
      rst=1'b1; 
		
		#6000000;
      rst=1'b0;
		// Add stimulus here

	end
	
	always
		#5 clk=~clk;
      
endmodule


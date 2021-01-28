`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:11:41 10/30/2020
// Design Name:   FourDigitLEDdriver
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partC/FourDigitLEDdriver_tb.v
// Project Name:  partC
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
	reg button;

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
		.rst(rst), 
		.clk(clk), 
		.button(button), 
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
	integer i=0;
	initial begin
		// Initialize Inputs
		rst = 0;
		clk = 0;
		button = 0;

		// Wait 100 ns for global reset to finish
		#85 rst=1'b1;		
		#200 rst=1'b0; i=0;
		
		
		#1600 button=1'b1 ;
		#7000 button=0;
		
		#600 button=1'b1;
		#6000000 button=0;
		
		
		#1000 button=1'b1;
		#7000 button=0;
		
		// Add stimulus here

	end
      
	always
	begin
		#5 clk=~clk;
		i=i+1;
	end
endmodule


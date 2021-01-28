`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:40:41 10/21/2020
// Design Name:   FSM
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partB/FSM_tb.v
// Project Name:  partB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire an3;
	wire an2;
	wire an1;
	wire an0;
	wire[3:0] char;

	// Instantiate the Unit Under Test (UUT)
	FSM uut (
		.clk(clk), 
		.rst(rst), 
		.an3(an3), 
		.an2(an2), 
		.an1(an1), 
		.an0(an0), 
		.char(char)
	);
	integer i=0;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100
		rst=1'b1;
		
		#100
		rst=1'b0;
		// Add stimulus here
		
		
		for(i=0;i<'d500;i=i+1)
		begin
		#50
		clk=~clk;
		end
	end
      
endmodule


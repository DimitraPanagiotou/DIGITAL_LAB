`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:51:33 10/30/2020
// Design Name:   FSM
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partC/FSM_tb.v
// Project Name:  partC
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
	reg button;

	// Outputs
	wire an3;
	wire an2;
	wire an1;
	wire an0;
	wire [3:0] char;

	// Instantiate the Unit Under Test (UUT)
	FSM uut (
		.clk(clk), 
		.rst(rst), 
		.button(button), 
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
		button = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst=1;
		for(i=0;i<15;i=i+1)
		begin
			#10 clk=~clk;
		end
      rst=1'b0;
		button=1'b0;
		 
		for(i=0;i<15;i=i+1)
		begin
			#10 clk=~clk;
		end
		button=1'b0;
		
		for(i=0;i<15;i=i+1)
		begin
			#10 clk=~clk;
		end
		button=1'b0;
		
		for(i=0;i<15;i=i+1)
		begin
			#10 clk=~clk;
		end
		button=1'b0;
		
		for(i=0;i<15;i=i+1)
		begin
			#10 clk=~clk;
		end
	
		
		
		for(i=0;i<15000;i=i+1)
		begin
			#10 clk=~clk;
			if(i % 100==0)
				button=~button;
		end
		
		
		
		// Add stimulus here

	end
	
      
endmodule


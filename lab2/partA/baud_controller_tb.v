`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:44 11/09/2020
// Design Name:   baud_controller
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment2/partA/baud_controller_tb.v
// Project Name:  partA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: baud_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module baud_controller_tb;

	// Inputs
	reg reset;
	reg clk;
	reg [2:0] baud_select;

	// Outputs
	wire sample_ENABLE;

	// Instantiate the Unit Under Test (UUT)
	baud_controller uut (
		.reset(reset), 
		.clk(clk), 
		.baud_select(baud_select), 
		.sample_ENABLE(sample_ENABLE)
	);

initial
	begin
		clk = 1'b1;
		
		
		#200 reset = 1'b1;
		
		#100 reset = 1'b0;
		
		baud_select = 3'b111;
		
		#4000 baud_select = 3'b110;
		
		#5000 baud_select = 3'b101;
		
		#6000 baud_select = 3'b100;
		
		#10000 baud_select = 3'b011;
		
	end

	always 
		begin
		#5 clk = ~clk;
		end

      
endmodule


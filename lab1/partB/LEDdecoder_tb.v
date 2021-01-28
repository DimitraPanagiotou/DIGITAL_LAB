`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:07:30 10/18/2020
// Design Name:   LEDdecoder
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/LedDecoder_tb.v
// Project Name:  assignment1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LEDdecoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LedDecoder_tb;

	// Inputs
	reg [3:0] char;

	// Outputs
	wire [6:0] LED;
	integer i;
	// Instantiate the Unit Under Test (UUT)
	LEDdecoder uut (
		.char(char), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		char = 0;
		i=0;

		// Wait 100 ns for global reset to finish
		
		// Add stimulus here
		
		for(i=0 ; i <'d16 ; i=i+1)
		begin 
			#100
			char=char+1;
		end

	end
	

      
endmodule


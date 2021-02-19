`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:54:28 01/30/2021
// Design Name:   lcd_driver
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment4/LCD_DRIVER/lcd_driver_tb.v
// Project Name:  LCD_DRIVER
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lcd_driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lcd_driver_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire LCD_RS,LCD_E;
	wire LCD_RW;
	wire [3:0] SF_D;


	// Instantiate the Unit Under Test (UUT)
	lcd_driver uut (
		.clk(clk), 
		.reset(reset), 
		.LCD_RS(LCD_RS), 
		.LCD_E(LCD_E),
		.LCD_RW(LCD_RW), 
		.SF_D(SF_D)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		
		///////////////////////////testing///////////////////////////////
//reset the fsm unit
		#100 reset = 1'b1;
		#1000 reset = 1'b0;
		
	end
	always 
		#10 clk = ~clk;
      
endmodule


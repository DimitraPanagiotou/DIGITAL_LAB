`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:56:21 11/28/2020
// Design Name:   uart
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment2/partD/uart_tb.v
// Project Name:  partD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_tb;

	// Inputs
	reg reset;
	reg clk;
	reg [7:0] Tx_DATA;
	reg [2:0] baud_select;
	reg Tx_WR;
	reg Tx_EN;
	reg Rx_EN;

	// Outputs
	wire Tx_BUSY;
	wire [7:0] Rx_DATA;
	wire Rx_FERROR;
	wire Rx_PERROR;
	wire Rx_VALID;

	// Instantiate the Unit Under Test (UUT)
	uart uut (
		.reset(reset), 
		.clk(clk), 
		.Tx_DATA(Tx_DATA), 
		.baud_select(baud_select), 
		.Tx_WR(Tx_WR), 
		.Tx_EN(Tx_EN),  
		.Tx_BUSY(Tx_BUSY), 
		.Rx_DATA(Rx_DATA), 
		.Rx_EN(Rx_EN), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		Tx_DATA = 0;
		baud_select = 0;
		Tx_WR = 0;
		Tx_EN = 0;
		Rx_EN = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset=1'b1;
		
		#1000;
      reset=1'b0;
		
		// Add stimulus here
		//activate both modules
		baud_select = 3'b111;
		Tx_EN = 1'b1;
		Rx_EN = 1'b1;
		
		
		//dataset(AA) ready for transmission
		#100 Tx_DATA = 8'b10101010;
		
	   Tx_WR = 1'b1;
		#10 Tx_WR = 1'b0;
		
		//dataset(55) ready for transmission
		#200000 Tx_DATA = 8'h55;
		
	   Tx_WR = 1'b1;
		#10 Tx_WR = 1'b0;
		
		
		//dataset(CC) ready for transmission
		#200000 Tx_DATA = 8'hCC;
		
	   Tx_WR = 1'b1;
		#10 Tx_WR = 1'b0;
		
		//dataset(89) ready for transmission
		#200000 Tx_DATA = 8'h89;
		
	   Tx_WR = 1'b1;
		#10 Tx_WR = 1'b0;
		
	end
   
	always
		#5 clk=~clk;
endmodule


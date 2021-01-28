`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:54 11/10/2020
// Design Name:   uart_transmitter
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment2/partB/uart_transmitter_tb.v
// Project Name:  partB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_transmitter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_transmitter_tb;

	// Inputs
	reg reset;
	reg clk;
	reg [7:0] Tx_DATA;
	reg [2:0] baud_select;
	reg Tx_WR;
	reg Tx_EN;

	// Outputs
	wire TxD;
	wire Tx_BUSY;

	// Instantiate the Unit Under Test (UUT)
	uart_transmitter uut (
		.reset(reset), 
		.clk(clk), 
		.Tx_DATA(Tx_DATA), 
		.baud_select(baud_select), 
		.Tx_WR(Tx_WR), 
		.Tx_EN(Tx_EN), 
		.TxD(TxD), 
		.Tx_BUSY(Tx_BUSY)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		Tx_DATA = 0;
		baud_select = 0;
		Tx_WR = 0;
		Tx_EN = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=1;
		
		
		//change of input 
		#100
		reset=1'b0;
		baud_select=3'b111;
		Tx_DATA=8'b10101010;
		Tx_EN=1'b1;
		
		
		#95
		Tx_WR=1'b1;
		#10
		Tx_WR=1'b0;
		
        
		// Add stimulus here

		#1000005
		Tx_DATA=8'b11001100;
		Tx_WR=1'b1;
		#10
		Tx_WR=1'b0;
		
		
		
		#1000005
		Tx_DATA=8'b11110000;
		Tx_WR=1'b1;
		#10
		Tx_WR=1'b0;
		
	end
always
	#5 clk=~clk;

      
endmodule


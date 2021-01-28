`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:54:55 11/21/2020
// Design Name:   uart_receiver
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment2/partC/uart_receiver_tb.v
// Project Name:  partC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_receiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_receiver_tb;

	// Inputs
	reg reset;
	reg clk;
	reg [2:0] baud_select;
	reg Rx_EN;
	reg RxD;

	// Outputs
	wire [7:0] Rx_DATA;
	wire Rx_FERROR;
	wire Rx_PERROR;
	wire Rx_VALID;

	// Instantiate the Unit Under Test (UUT)
	uart_receiver uut (
		.reset(reset), 
		.clk(clk), 
		.Rx_DATA(Rx_DATA), 
		.baud_select(baud_select), 
		.Rx_EN(Rx_EN), 
		.RxD(RxD), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		baud_select = 0;
		Rx_EN = 0;
		RxD = 1;

		// Wait 100 ns for global reset to finish
		#100 reset = 1'b1; 
		baud_select = 3'b111;
		// Add stimulus here
		#100 reset =1'b0;
		#1000 Rx_EN = 1'b1;
		
		
		//first receival
		#500 RxD = 0;  //start_bit
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;//parity_bit
		#8640 RxD = 1;//stop_bit
		

		//expected Rx_PERROR
		#50000 RxD = 0;  //start_bit
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 1;//parity_bit
		#8640 RxD = 1;//stop_bit
		
		
		#50000 RxD = 0;  //start_bit
		#8640 RxD = 0;
		#8640 RxD = 0;
		#8640 RxD = 0;
		#8640 RxD = 0;
		#8640 RxD = 1;
		#8640 RxD = 1;
		#8640 RxD = 1;
		#8640 RxD = 1;
		#8640 RxD = 0;//parity_bit
		#8640 RxD = 1;//stop_bit
		
		
	end
always
	#5 clk = ~clk;
endmodule


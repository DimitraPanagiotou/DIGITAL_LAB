`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:45:01 11/25/2020 
// Design Name: 
// Module Name:    uart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD,
Rx_FERROR, Rx_PERROR, Rx_VALID);
input reset, clk;
input [2:0] baud_select;
input Rx_EN;
input RxD;
output [7:0] Rx_DATA ;
output  Rx_FERROR; // Framing Error //
output  Rx_PERROR; // Parity Error //
output  Rx_VALID; // Rx_DATA is Valid //

wire new_reset;

resetSynchronizer resetSynchronizerRecIn(
.clk(clk),
.rst(reset),
.new_rst(new_reset)
);

uart_receiver uut1(
		.reset(new_reset), 
		.clk(clk), 
		.Rx_DATA(Rx_DATA), 
		.baud_select(baud_select), 
		.Rx_EN(Rx_EN), 
		.RxD(RxD), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID)
	);

endmodule

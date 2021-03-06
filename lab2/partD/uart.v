`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:48:04 11/28/2020 
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
module uart(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN,Tx_BUSY, Rx_DATA, Rx_EN,Rx_FERROR, Rx_PERROR, Rx_VALID);

input reset, clk;
input [7:0] Tx_DATA;
input [2:0] baud_select;
input Tx_EN;
input Tx_WR;
input Rx_EN;



wire  TxD;
output  Tx_BUSY;
output  [7:0] Rx_DATA;
output  Rx_FERROR; // Framing Error //
output  Rx_PERROR; // Parity Error //
output  Rx_VALID; // Rx_DATA is Valid //


	transmitter transmitterInstance (
		.reset(reset), 
		.clk(clk), 
		.Tx_DATA(Tx_DATA), 
		.baud_select(baud_select), 
		.Tx_WR(Tx_WR), 
		.Tx_EN(Tx_EN), 
		.TxD(TxD), 
		.Tx_BUSY(Tx_BUSY)
	);
	
	receiver receiverInstance(
		.reset(reset), 
		.clk(clk), 
		.Rx_DATA(Rx_DATA), 
		.baud_select(baud_select), 
		.Rx_EN(Rx_EN), 
		.RxD(TxD), 
		.Rx_FERROR(Rx_FERROR), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_VALID(Rx_VALID)
	);



endmodule

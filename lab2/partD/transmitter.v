`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:08 11/25/2020 
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
module transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);
input reset, clk;
input [7:0] Tx_DATA;
input [2:0] baud_select;
input Tx_EN;
input Tx_WR;
output  TxD;
output  Tx_BUSY;

wire new_reset;

resetSynchronizer resetSynchIn (
.clk(clk),
.rst(reset),
.new_rst(new_reset)
);

uart_transmitter uut2 (
		.reset(new_reset), 
		.clk(clk), 
		.Tx_DATA(Tx_DATA), 
		.baud_select(baud_select), 
		.Tx_WR(Tx_WR), 
		.Tx_EN(Tx_EN), 
		.TxD(TxD), 
		.Tx_BUSY(Tx_BUSY)
);


endmodule

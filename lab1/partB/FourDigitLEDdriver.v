`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:25 10/21/2020 
// Design Name: 
// Module Name:    FourDigitLEDdriver 
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
module FourDigitLEDdriver(reset, clk, an3, an2, an1, an0,
a, b, c, d, e, f, g, dp);

input clk, reset;
output an3, an2, an1, an0;
output a, b, c, d, e, f, g, dp;

wire clk_fb;
wire new_rst,clean_rst;
wire[3:0] char;
wire[6:0] LED;

resetSynchronizer synchronizer(
		.clk(clk), 
		.rst(reset), 
		.new_rst(new_rst)
	);


debouncer rstDebouncer(
		.rst(new_rst),
		.clk(clk),
		.clean_rst(clean_rst)
	);
	

FSM mainControler(
		.clk(clk), 
		.rst(clean_rst), 
		.an3(an3), 
		.an2(an2), 
		.an1(an1), 
		.an0(an0), 
		.char(char)
	);

LEDdecoder decoder(
		.char(char),
		.LED(LED)
	);


assign a  = LED[6];
assign b  = LED[5];
assign c  = LED[4];
assign d  = LED[3];
assign e  = LED[2];
assign f  = LED[1];
assign g  = LED[0];
assign dp = 1'b1;

endmodule

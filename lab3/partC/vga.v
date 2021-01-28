`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:03:16 12/16/2020 
// Design Name: 
// Module Name:    vga 
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
module vga(clk,reset,RED,GREEN,BLUE,HSYNQ,VSYNQ);
input clk,reset;
output RED,GREEN,BLUE,HSYNQ,VSYNQ;


wire display,vdisplay;
wire RED,GREEN,BLUE,HSYNQ,VSYNQ;

hsynq_generator HsynqGeneratorInstance (
		.clk(clk), 
		.reset(reset), 
		.hsynq(HSYNQ),
		.display(display)
);

vsynq_generator VsynqGeneratorInstance (
		.clk(clk), 
		.reset(reset), 
		.vsynq(VSYNQ),
		.vdisplay(vdisplay)
);


pixel_controller pixelControllerInstance(
		.clk(clk),
		.reset(reset),
		.display(display),
		.vdisplay(vdisplay),
		.red(RED),
		.green(GREEN),
		.blue(BLUE)
);


endmodule

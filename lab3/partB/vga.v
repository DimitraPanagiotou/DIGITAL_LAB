`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:09:59 12/12/2020 
// Design Name: 
// Module Name:    vga 
// Project Name: 
// Target Devices: 
// Tool versions: `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:16:17 12/09/2020 
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
module vga(clk,reset,red,green,blue);
input clk,reset;
output red,green,blue;


wire display;
wire red,green,blue;

hsynq_generator HsynqGeneratorInstance (
		.clk(clk), 
		.reset(reset), 
		.hsynq(hsynq),
		.display(display)
);

pixel_controller pixelControllerInstance(
		.clk(clk),
		.reset(reset),
		.display(display),
		.red(red),
		.green(green),
		.blue(blue)
);


endmodule

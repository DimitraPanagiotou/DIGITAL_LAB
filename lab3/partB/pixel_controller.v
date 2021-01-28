`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:23:22 12/09/2020 
// Design Name: 
// Module Name:    pixelcontroller 
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
module pixel_controller(clk,reset,display,red,green,blue);
input clk,reset,display;
output red,green,blue;

parameter 
	HORIZONTAL_PIXELS = 7'd127; 

wire [13:0] bram_address;
wire bram_red,bram_green,bram_blue;
reg en;
reg[6:0] HPIXEL;//horizontal position on the original image
reg [3:0] h_anal_counter;//counters to fit the 128x96 image in the final 640x480 image 

bram bramInstance (
		.clk(clk), 
		.reset(reset), 
		.en(en), 
		.address(bram_address), 
		.red(bram_red), 
		.green(bram_green), 
		.blue(bram_blue)
);

//always block which controls the horizontal position of the original image
always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		en = 1'b0;
		HPIXEL=7'b0;
		h_anal_counter=4'b0000;
	end
	else if(display)
	begin
		en = 1'b1;
		if(h_anal_counter ==  4'b1001) ////in order to repeat the same pixel x5       //achieved analysis 640 bits per line from 128 bits per line from the original image 
		begin
			if(HPIXEL==HORIZONTAL_PIXELS)
			begin
				HPIXEL = HORIZONTAL_PIXELS;
				h_anal_counter = 4'b0000;
			end
			else
			begin
				HPIXEL = HPIXEL + 1'b1;
				h_anal_counter = 4'b0000;
			end
		end
		else
			h_anal_counter = h_anal_counter + 1'b1;
	end
	else 
	begin
		//en=1'b0; **??**
		HPIXEL=7'b0;															   		
		h_anal_counter=4'b0000;
	end
end

assign bram_address =  'd9216 + HPIXEL;//address 9216 consist of multicolor line


assign red = (display) ? bram_red : 1'b0;
assign green = (display) ? bram_green : 1'b0;
assign blue = (display) ? bram_blue : 1'b0;

endmodule

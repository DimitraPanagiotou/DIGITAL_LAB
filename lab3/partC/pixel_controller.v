`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:35 12/16/2020 
// Design Name: 
// Module Name:    pixel_controller 
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
module pixel_controller(clk,reset,display,vdisplay,red,green,blue);
input clk,reset,display,vdisplay;
output red,green,blue;

parameter 
	VERTICAL_PIXELS = 7'd95,
	HORIZONTAL_PIXELS = 7'd127; 

wire [13:0] bram_address;
wire bram_red,bram_green,bram_blue;
reg en,finished_line;
reg[6:0] VPIXEL,HPIXEL;//horizontal position on the original image
reg [2:0] v_anal_counter;//counters to fit the 128x96 image in the final 640x480 image 
reg [3:0] h_anal_counter;
reg prev_vdisplay;

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
		h_anal_counter=4'b0;
		finished_line = 1'b0;
	end
	else if(display && vdisplay)
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
		finished_line = (HPIXEL==HORIZONTAL_PIXELS) ? 1'b1 : 1'b0; //signal informing the system that a complete line has been accessed succesfully
		HPIXEL=7'b0;															   		
		h_anal_counter=4'b0;
	end
end



//always block which controls the vertical position of the original image
always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		VPIXEL=7'b0;
		v_anal_counter=3'b0;
	end
	//at the beggining of every vdisplayl VPIXEL is set to 0
	else if(vdisplay && finished_line)
	begin
		if(v_anal_counter ==  3'b100) ////in order to repeat the same pixel x5       //achieved analysis 640 bits per line from 128 bits per line from the original image 
		begin
			if(VPIXEL==VERTICAL_PIXELS)
			begin
				VPIXEL = 7'b0;
				v_anal_counter = 3'b00;
			end
			else
			begin
				VPIXEL = VPIXEL + 1'b1;
				v_anal_counter = 3'b00;
			end
		end
		else
			v_anal_counter = v_anal_counter + 1'b1;
	end
	
end




assign bram_address = VPIXEL*(HORIZONTAL_PIXELS+1'b1) + HPIXEL;


assign red = (display && vdisplay) ? bram_red : 1'b0;
assign green = (display && vdisplay) ? bram_green : 1'b0;
assign blue = (display && vdisplay) ? bram_blue : 1'b0;

endmodule





`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:07 12/16/2020 
// Design Name: 
// Module Name:    vsynq_generator 
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
module vsynq_generator(clk,reset,vsynq,vdisplay);
input clk;
input reset;
output reg vsynq,vdisplay;


parameter 
	MAX_COUNTER_VALUE = 20'd833599;
	

  
reg [19:0] interval_counter;

//Always block controllinq interval_counter value 
always@(posedge clk or posedge reset)
begin
	if(reset) 
		interval_counter =  11'b0;
	else if (interval_counter == MAX_COUNTER_VALUE)
		interval_counter =  11'b0;
	else
		interval_counter = interval_counter + 1'b1;
end


//According to interval_counter value 
//signals vsynq and vdisplay are assigned
always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
		vsynq=1'b1;
		vdisplay=1'b0;
	end
	else
	begin
		case(interval_counter)
			'd0: 
			begin
				vsynq=1'b0;
				vdisplay=1'b0;
			end
			'd3200: 
			begin
				vsynq=1'b1;
				vdisplay=1'b0;
			end
			'd49600: 
			begin
				vdisplay=1'b1;
				vsynq=1'b1;
			end
			'd817600: 
			begin
				vdisplay=1'b0;
				vsynq=1'b1;
			end
		endcase
	end
end	



endmodule

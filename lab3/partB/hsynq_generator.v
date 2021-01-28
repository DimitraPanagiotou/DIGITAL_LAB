`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:02 12/08/2020 
// Design Name: 
// Module Name:    hsynq_generator 
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
module hsynq_generator(clk,reset,hsynq,display);
input clk;
input reset;
output reg hsynq,display;

reg new_hsynq,new_display;
parameter 
	MAX_COUNTER_VALUE = 11'd1599;
	

  
reg [10:0] interval_counter;

always@(posedge clk or posedge reset)
begin
	if(reset) 
		interval_counter =  11'b0;
	else if (interval_counter == MAX_COUNTER_VALUE)
		interval_counter =  11'b0;
	else
		interval_counter = interval_counter + 1'b1;
end


always @(posedge clk or posedge reset)
begin
	if(reset)
		display = 1'b0;
	else
		display = new_display;
end



always @(posedge clk or posedge reset)
begin
	if(reset)
		hsynq = 1'b0;
	else
		hsynq = new_hsynq;
end



always @(interval_counter or reset)
begin
	if(reset)
	begin
		new_hsynq=1'b1;
		new_display=1'b0;
	end
	else
	begin
		case(interval_counter)
			'd0: 
			begin
				new_hsynq=1'b0;
				new_display=1'b0;
			end
			'd192: 
			begin
				new_hsynq=1'b1;
				new_display=1'b0;
			end
			'd288: 
			begin
				new_hsynq=1'b1;
				new_display=1'b1;
			end
			'd1568: 
			begin
				new_hsynq=1'b1;
				new_display=1'b0;
			end
			default:
			begin
				new_hsynq=hsynq;
				new_display=display;
			end
		endcase
	end
end	



endmodule

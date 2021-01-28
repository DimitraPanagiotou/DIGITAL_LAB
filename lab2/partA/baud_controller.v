`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:19 11/09/2020 
// Design Name: 
// Module Name:    baud_controller 
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
module baud_controller(reset, clk, baud_select, sample_ENABLE);

input reset, clk;
input [2:0] baud_select;
output reg sample_ENABLE;
reg [15:0] period_counter;
reg [15:0] sample_period_counter;



//ff which is triggered by changes in baud_select
//main purpose of the block is to assign the right value of sample_period_cycles
//according to the agreed baut rate frequency  
always @(baud_select)
begin
	case(baud_select)
		3'b000: sample_period_counter = 'd20833;//16'b0101000101100001 //0101_0001_0110_0001 = 20833
	 
		3'b001: sample_period_counter = 'd5208; //16'b0001010001011000; //0001_0100_0101_1000 = 5208
    
		3'b010: sample_period_counter = 'd1302; //16'b0000010100010110; //0000_0101_0001_0110 = 1302
    
		3'b011: sample_period_counter = 'd651; //16'b0000001010001011; //0000_0010_1000_1011 = 651
    
		3'b100: sample_period_counter = 'd326; //16'b0000000101000110; //0000_0001_0100_0110 = 326
    
		3'b101: sample_period_counter = 'd163; //16'b0000000010100011; //0000_0000_1010_0011 = 163
    
		3'b110: sample_period_counter = 'd108; //16'b0000000001101100; //0000_0000_0110_1100 = 108
    
		3'b111: sample_period_counter = 'd54; //16'b0000000000110110; //0000_0000_0011_0110 = 54
    
		default: sample_period_counter = 16'bx_x;
	endcase
end	

//counter manipulation (with reset check)
always @(posedge clk or posedge reset)
begin
  if(reset)
		period_counter = 16'b0;
  else
		period_counter = (period_counter == sample_period_counter - 1'b1) ? 16'b0 : period_counter + 1'b1;
end

//sample_ENABLE pulse generator
always @(period_counter)
begin
  sample_ENABLE = (period_counter == sample_period_counter - 1'b1) ? 1'b1 : 1'b0;
end
endmodule


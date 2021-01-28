`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:55:16 10/22/2020 
// Design Name: 
// Module Name:    debouncer 
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
///a module that creates rst pulse 
///if the initial reset signal lasts for more
///than a certain number of clock cycles
////////////////////////////////////////////////////////////

module debouncer#(parameter MIN_CYCLES = 250000)
(
    input clk,
    input rst,
    output reg clean_rst
);
reg [19:0]counter=4'b0;
	 
always @(posedge clk)
begin
	//in case we receive rst=1 we raise the counter
	//until it reaches a certain value=MIN_CYCLES
	if(rst==1'b1)
	begin
		counter = counter + 1'b1;
		if(counter==MIN_CYCLES)
		begin
			clean_rst=1'b1;
			counter=4'b0; 
		end
	end
	else
	begin
		clean_rst=1'b0;
		counter=4'b0;
	end

end


endmodule

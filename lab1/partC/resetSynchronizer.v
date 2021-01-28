`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:26:18 10/21/2020 
// Design Name: 
// Module Name:    resetConverter 
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
//resetSynchronizer module uses 2 flip-flops. 
//   The first one is to ensure that there will be no setup problem
//   and the second one is for the metastability.
//////////////////////////////////////////////////////////////////////////////////
module resetSynchronizer(
    input clk,
    input rst,
    output reg new_rst
    );

reg temp;


always@(posedge clk)
begin
	new_rst=temp;
end

always@(posedge clk)
begin
	temp=rst;
end

endmodule

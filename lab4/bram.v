`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:32 01/17/2021 
// Design Name: 
// Module Name:    bram 
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
module bram(clk,address,character);
input clk;
input [10:0] address;
output [7:0] character;


   RAMB16_S9 #(
      .INIT(9'h000),  // Value of output RAM registers at startup
      .SRVAL(9'h000), // Output value upon SSR assertion
      .WRITE_MODE("WRITE_FIRST"), // WRITE_FIRST, READ_FIRST or NO_CHANGE
		
		// Address 0 to 255
      //<first line> ABCDEFGHIJKLMNOP 
		//<second line> abcdefghijklmno(cursor)
		.INIT_00(256'hFF_6F_6E_6D_6C_6B_6A_69_68_67_66_65_64_63_62_61_50_4F_4E_4D_4C_4B_4A_49_48_47_46_45_44_43_42_41)
   ) RAMB16_S9_inst (
      .DO(character),// 8-bit output
      .ADDR(address),  // 11-bit address input
      .CLK(clk),    // Clock
      .EN(1'b1),      // RAM Enable Input
      .SSR(1'b0),    // Synchronous Set/Reset Input
      .WE(1'b0)       // Write Enable Input
   );
endmodule

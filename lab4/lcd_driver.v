`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:22 01/17/2021 
// Design Name: 
// Module Name:    lcd_driver 
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
module lcd_driver(clk,reset,LCD_RS,LCD_RW,SF_D,LCD_E);

input clk,reset;
output wire LCD_RS,LCD_RW,LCD_E;
output wire [3:0] SF_D;
wire new_reset,bit_position;

wire [7:0] as_sf_d;
wire M_LCD_RS,M_LCD_RW,I_LCD_E,INSTR_LCD_E;
wire [7:0] M_SF_D,I_SF_D;
wire instruction_done,init_done;
wire Ienable;

assign as_sf_d = (init_done) ? M_SF_D : I_SF_D;
assign LCD_E  = (init_done) ? INSTR_LCD_E : I_LCD_E;
assign LCD_RS = (init_done) ? M_LCD_RS : 1'b0;
assign LCD_RW = (init_done) ? M_LCD_RW : 1'b0;

assign SF_D = (bit_position  || (!init_done)) ? as_sf_d[3:0] : as_sf_d[7:4] ; 

resetSynchronizer RESETSYNCHRONIZER(
    .clk(clk),
    .rst(reset),
    .new_rst(new_reset)
);


initialization_fsm InitializationModule(
		.clk(clk), 
		.reset(new_reset), 
		.init_done(init_done), 
		.I_LCD_E(I_LCD_E), 
		.I_SF_D(I_SF_D)
);

main_fsm MainFsm (   //fsm responsible for configuration and display control
		.clk(clk), 
		.reset(new_reset), 
		.instruction_done(instruction_done), 
		.Ienable(Ienable),
		.init_done(init_done), 
		.M_LCD_RS(M_LCD_RS), 
		.M_LCD_RW(M_LCD_RW), 
		.M_SF_D(M_SF_D)
);

instruction_fsm InstructionModule (
		.clk(clk), 
		.reset(reset), 
		.activate_signal(Ienable), 
		.INSTR_LCD_E(INSTR_LCD_E),
		.instruction_done(instruction_done), 
		.bit_position(bit_position)
	);

endmodule

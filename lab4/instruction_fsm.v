`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:03 01/17/2021 
// Design Name: 
// Module Name:    instruction_fsm 
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
module instruction_fsm(clk,reset,activate_signal,instruction_done,bit_position,INSTR_LCD_E);
input clk , reset , activate_signal;//LCD_E
output reg INSTR_LCD_E ;
output reg instruction_done; //carry the information that a 8-bit write process has completed
output wire bit_position; //concerning the position of bits in write position: upper or lower
reg [11:0]counter;
reg [2:0] state , next_state;


//different states
parameter
	upper_setup = 3'b000,
	upper_data = 3'b001,
	upper_hold = 3'b010,
	wait_for_lower= 3'b011,
	lower_setup = 3'b100,
	lower_data = 3'b101,
	lower_hold = 3'b110,
	end_state = 3'b111;

//counters
parameter
	initialization_delay = 'b00000000001,//2
	write_delay = 'b00000001100,//12
	hold_delay = 'b00000000001, //1
	next_bits_delay = 'b00001000001, //65 : adding previous delays
	complete_instruction_delay = 'b100000100000; //2080

parameter 
	upper = 1'b0,
	lower = 1'b1;

assign bit_position = (state == upper_setup ||
                state == upper_data  ||
                state == upper_hold ) ? upper : lower;

always@(posedge clk or posedge reset)
begin
	if(reset)
		counter = 12'b0;
	else if(!activate_signal)
		counter = 12'b0;
	else if(counter == complete_instruction_delay)
		counter = 12'b0;
	else
		counter = counter + 1'b1;
end 
		
always@(posedge clk or posedge reset)
begin
	if(reset)
		state = upper_setup;
	else if(!activate_signal)
		state = upper_setup;
	else
		state = next_state;
end 


always @ (state or counter)
begin
	case(state)
		upper_setup : 
		begin
			INSTR_LCD_E = 1'b0;
			instruction_done = 1'b0;
			next_state = (counter == initialization_delay) ? upper_data : upper_setup;
		end
		upper_data : 
		begin
			INSTR_LCD_E = 1'b1;
			instruction_done = 1'b0;
			next_state = (counter == initialization_delay + write_delay) ? upper_hold :  upper_data;
		end
		upper_hold : 
		begin
			INSTR_LCD_E = 1'b0;
			instruction_done = 1'b0;
			next_state = (counter == initialization_delay + write_delay + hold_delay) ? wait_for_lower :  upper_hold;
		end
		wait_for_lower : 
		begin
			INSTR_LCD_E = 1'b0;
			instruction_done = 1'b0;
			next_state = (counter == next_bits_delay) ? lower_setup :  wait_for_lower;
		end
		lower_setup : 
		begin
			INSTR_LCD_E = 1'b0;
			instruction_done = 1'b0;
			next_state = (counter == next_bits_delay + initialization_delay) ? lower_data : lower_setup;
		end
		lower_data : 
		begin
			INSTR_LCD_E = 1'b1;
			instruction_done = 1'b0;
			next_state = (counter == next_bits_delay + initialization_delay + write_delay) ? lower_hold : lower_data;
		end
		lower_hold : 
		begin
			INSTR_LCD_E = 1'b0;
			instruction_done = 1'b0;
			next_state = (counter == next_bits_delay + initialization_delay + write_delay + hold_delay) ? end_state : lower_hold;
		end
		end_state : 
		begin
			INSTR_LCD_E = 1'b0;
			instruction_done = (counter == complete_instruction_delay ) ? 1'b1 : 1'b0;
			next_state = (counter == complete_instruction_delay ) ? upper_setup : end_state;
		end
		
	endcase
end
endmodule

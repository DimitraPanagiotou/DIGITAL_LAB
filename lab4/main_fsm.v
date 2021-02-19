`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:34 01/17/2021 
// Design Name: 
// Module Name:    main_fsm 
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

module main_fsm(clk,reset,instruction_done,init_done,Ienable,M_LCD_RS,M_LCD_RW,M_SF_D);
input clk,reset,init_done,instruction_done;
output reg M_LCD_RS,M_LCD_RW;
output reg [7:0] M_SF_D;
output reg Ienable;

reg [10:0] address;
wire [7:0] output_char;
reg line_completed;
reg [3:0] next_state,state;
reg [25:0] counter;
reg reset_counter;//so as to reset counter to 0 when it is nessecary
parameter 
		IDLE = 4'b0000,
		FUNCTION_SET = 4'b0001,
		ENTRY_SET = 4'b0010,
		SET_DISPLAY = 4'b0011,
		CLEAR_DISPLAY = 4'b0100,
		WAIT_1_64_MS = 4'b0101,
		SET_DDRAM_ADD_TOP = 4'b0110,
		DISPLAY_TOP_CHARACTER = 4'b0111,
		SET_DDRAM_ADD_BOTTOM = 4'b1000,
		DISPLAY_BOTTOM_CHARACTER = 4'b1001,
		REFRESH_STATE = 4'b1010,
		RETURN_CURSOR_HOME = 4'b1011;
		
	
//bram instance
bram bram_inst(.clk(clk), .address(address), .character(output_char));


//counter manipulation
always@(posedge clk or posedge reset)
begin
	if(reset)
		counter = 12'b0;
	else if(!Ienable)
		counter = 12'b0;
	else if(reset_counter)
		counter = 12'b0;
	else
		counter = counter + 1'b1;
end 

//next_state => state assignment		
always@(posedge clk or posedge reset)
begin
	if(reset)
		state = IDLE;
	else
		state = next_state;
end 

//address manipulation
//when SET_DDRAM_ADD address is set to 0 and during CHARACTER DISPLAY we increase address (1 bit per posedge clk)
//to access the next character in bram  
always @(posedge clk or posedge reset)
begin
	if(reset)
		address = 11'b0;
	else if(state == SET_DDRAM_ADD_TOP)
		address = 11'b0;
	else if (((state == DISPLAY_TOP_CHARACTER) || (state == DISPLAY_BOTTOM_CHARACTER)) && instruction_done)
	begin
		if(address =='d14 || address=='d30)///values were setted after simulation in order to achieve right memory access
			line_completed = 1'b1;
		else
			line_completed = 1'b0;
		
		address = address + 1'b1; //displaying the next character
	end
end




//main fsm
always @(state or counter or init_done or line_completed or instruction_done)
begin
	
	case(state)
		IDLE:
		begin
			reset_counter = 1'b0;
			M_SF_D = 8'b0000_0000;
			M_LCD_RS = 1'b0;
			M_LCD_RW = 1'b0;
			Ienable = 1'b0;
			next_state = (init_done) ? FUNCTION_SET : IDLE;
		end
////////////////////////CONFIGURATION////////////////////////
		FUNCTION_SET:
		begin
			M_SF_D = 8'h28;
			M_LCD_RS = 1'b0;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? ENTRY_SET : FUNCTION_SET;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		ENTRY_SET:
		begin
			M_SF_D = 8'h06;
			M_LCD_RS = 1'b0;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? SET_DISPLAY : ENTRY_SET;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		SET_DISPLAY:
		begin
			M_SF_D = 8'h0C;
			M_LCD_RS = 1'b0;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? CLEAR_DISPLAY : SET_DISPLAY;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		CLEAR_DISPLAY:
		begin
			M_SF_D = 8'h01;
			M_LCD_RS = 1'b0;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? WAIT_1_64_MS : CLEAR_DISPLAY;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		WAIT_1_64_MS:
		begin
			Ienable = 1'b1;
			M_SF_D = 8'h00;
			M_LCD_RS = 1'b0;
			M_LCD_RW = 1'b0;
			Ienable = (counter == 'd81998) ? 1'b0 : 1'b1;
			next_state = (counter == 'd81998) ?  SET_DDRAM_ADD_TOP : WAIT_1_64_MS ;
		end
////////////////////////END of CONFIGURATION////////////////////////

////////////////////////WRITE DATA////////////////////////
		SET_DDRAM_ADD_TOP:
		begin
			M_SF_D = 8'h80;
			M_LCD_RS = 1'b1;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? DISPLAY_TOP_CHARACTER : SET_DDRAM_ADD_TOP;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		DISPLAY_TOP_CHARACTER:
		begin
			M_SF_D = output_char;
			M_LCD_RS = 1'b1;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state =(line_completed && instruction_done) ? SET_DDRAM_ADD_BOTTOM : DISPLAY_TOP_CHARACTER;///////////////////////////////////////
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		SET_DDRAM_ADD_BOTTOM:
		begin
			reset_counter = 1'b0;
			M_SF_D = 8'hC0;
			M_LCD_RS = 1'b1;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? DISPLAY_BOTTOM_CHARACTER : SET_DDRAM_ADD_BOTTOM;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		DISPLAY_BOTTOM_CHARACTER:
		begin
			reset_counter = 1'b0;
			M_SF_D = output_char;
			M_LCD_RS = 1'b1;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state =(line_completed && instruction_done) ? REFRESH_STATE : DISPLAY_BOTTOM_CHARACTER;///////////////////////////////////////
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
		REFRESH_STATE:
		begin
			M_SF_D = 8'b0000_0000;
			M_LCD_RS = 1'b1;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state =(counter == 'd49999999) ? RETURN_CURSOR_HOME : REFRESH_STATE;///////////////////////////////////////
		end
		RETURN_CURSOR_HOME:
		begin
			M_SF_D = 8'b0000_001x;/////////////////////////////////////////////////////////////////////////////////////////
			M_LCD_RS = 1'b1;
			M_LCD_RW = 1'b0;
			Ienable = 1'b1;
			next_state = (instruction_done) ? SET_DDRAM_ADD_TOP : RETURN_CURSOR_HOME;
			Ienable = (instruction_done) ? 1'b0 : 1'b1;
		end
	endcase

end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:02 01/17/2021 
// Design Name: 
// Module Name:    initialization_fsm 
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
//////////////////////////////////////////////////////////////////////////////////`timescale 1ns / 1ps
module initialization_fsm(clk,reset,init_done,I_LCD_E,I_SF_D);
input clk,reset;
output reg I_LCD_E;//initialized LCD_E
output reg [7:0] I_SF_D;// initialized SF_D
output reg init_done;//assuring the system that initialization has completed

reg [3:0] state,next_state;
reg [19:0] counter;

//states
parameter
	WAIT_15_MS = 'b000,
	WAIT_FIRST_12 = 'b0001,
	WAIT_4_1_MS = 'b010,
	WAIT_SECOND_12 = 'b011,
	WAIT_100_US = 'b0100,
	WAIT_THIRD_12 = 'b101,
	WAIT_40_US = 'b110,
	WAIT_FORTH_12 = 'b111,
	WAIT_SECOND_40_US = 'b1000,
	DONE = 'b1001;


//delays
parameter 
	DELAY_15_MS = 'd749999,					//COUNTERS TO ACHIEVE TIMING IN INITIALIZATION
	DELAY_FIRST_12 = 'd750011,
	DELAY_4_1_MS = 'd955011,
	DELAY_SECOND_12 = 'd955023,
	DELAY_100_US = 'd960023,
	DELAY_THIRD_12 = 'd960035,
	DELAY_40_US = 'd962035,
	DELAY_FORTH_12 = 'd962047,
	DELAY_SECOND_40_US = 'd964046;

//counter manipulation
always@(posedge clk or posedge reset)
begin
	if(reset)
		counter = 12'b0;
	else if(counter == DELAY_SECOND_40_US)
		counter = DELAY_SECOND_40_US;
	else
		counter = counter + 1'b1;
end 

//next_state => state assignment		
always@(posedge clk or posedge reset)
begin
	if(reset)
		state = WAIT_15_MS;
	else
		state = next_state;
end 

//initialization sequence
always@(state or counter)
begin
	case(state)

		WAIT_15_MS:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0000;
			I_LCD_E = 1'b0;
			next_state = (counter == DELAY_15_MS) ? WAIT_FIRST_12 : WAIT_15_MS;
		end
		
		WAIT_FIRST_12:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0011;
			I_LCD_E = 1'b1;
			next_state = (counter == DELAY_FIRST_12) ? WAIT_4_1_MS : WAIT_FIRST_12;
		end
		
		WAIT_4_1_MS:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0000;
			I_LCD_E = 1'b0;
			next_state = (counter == DELAY_4_1_MS) ? WAIT_SECOND_12 : WAIT_4_1_MS;
		end
		
		
		WAIT_SECOND_12:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0011;
			I_LCD_E = 1'b1;
			next_state = (counter == DELAY_SECOND_12) ? WAIT_100_US : WAIT_SECOND_12;
		end
		
		WAIT_100_US:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0000;
			I_LCD_E = 1'b0;
			next_state = (counter == DELAY_100_US) ? WAIT_THIRD_12 : WAIT_100_US;
		end
		
		WAIT_THIRD_12:
		begin
			init_done = 1'b0;
			I_SF_D =8'b0000_0011;
			I_LCD_E = 1'b1;
			next_state = (counter == DELAY_THIRD_12) ? WAIT_40_US : WAIT_THIRD_12;
		end
		
		
		WAIT_40_US:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0000;
			I_LCD_E = 1'b0;
			next_state = (counter == DELAY_40_US) ? WAIT_FORTH_12 : WAIT_40_US;
		end
		
		WAIT_FORTH_12:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0010;
			I_LCD_E = 1'b1;
			next_state = (counter == DELAY_FORTH_12) ? WAIT_SECOND_40_US : WAIT_FORTH_12;
		end
		
		
		WAIT_SECOND_40_US:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b0000_0000;
			I_LCD_E = 1'b0;
			next_state = (counter == DELAY_SECOND_40_US) ? DONE: WAIT_SECOND_40_US;
		end
	
		DONE:
		begin
			init_done = 1'b1;
			I_SF_D = 8'b0000_0000;
			I_LCD_E = 1'b0;
			next_state = (reset) ? WAIT_15_MS : DONE;
		end
		
		default:
		begin
			init_done = 1'b0;
			I_SF_D = 8'b00;
			I_LCD_E = 1'b0;
			next_state = 3'b000;
		end
	endcase	
end


endmodule

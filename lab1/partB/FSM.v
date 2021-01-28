`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:39 10/21/2020 
// Design Name: 
// Module Name:    FSM 
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
//Description
//the module is initialised when reset is set to 1
//if reset=0 all the anodes and the counter have a value=x 
//TRUTH TABLE
// *  state/count  | an3 | an2 | an1 | an0 || char
//  -----------------------------------------------------------------
//        1111     |  1  |  1  |  1  |  1  ||  0  
//        1110     |  0  |  1  |  1  |  1  ||  0 
//        1101     |  1  |  1  |  1  |  1  ||  0 
//        1100     |  1  |  1  |  1  |  1  ||  0 <-set value(an3)
//        1011     |  1  |  1  |  1  |  1  ||  1
//        1010     |  1  |  0  |  1  |  1  ||  1  
//        1001     |  1  |  1  |  1  |  1  ||  1   
//        1000     |  1  |  1  |  1  |  1  ||  1 <-set value(an2)  
//        0111     |  1  |  1  |  1  |  1  ||  2   
//        0110     |  1  |  1  |  0  |  1  ||  2  
//        0101     |  1  |  1  |  1  |  1  ||  2  
//        0100     |  1  |  1  |  1  |  1  ||  2 <-set value(an1)
//        0011     |  1  |  1  |  1  |  1  ||  3  
//        0010     |  1  |  1  |  1  |  0  ||  3  
//        0001     |  1  |  1  |  1  |  1  ||  3   
//        0000     |  1  |  1  |  1  |  1  ||  3 <-set value(an0) 
///////////////////////////////////////////////////////////////////////////////////

module FSM(clk,rst,an3,an2,an1,an0,char);
input clk;
input rst;
output reg an3;
output reg an2;
output reg an1;
output reg an0;
output reg[3:0] char;

parameter prepAn3 = 4'b1111,
          openAn3 = 4'b1110,
          closeAn3 = 4'b1101,
          setAn2 = 4'b1100,
          prepAn2 = 4'b1011,
          openAn2 = 4'b1010,
          closeAn2 = 4'b1001,
          setAn1 = 4'b1000,
          prepAn1 = 4'b0111,
          openAn1 = 4'b0110,
          closeAn1 = 4'b0101,
          setAn0 = 4'b0100,
          prepAn0 = 4'b0011,
          openAn0 = 4'b0010,
          closeAn0 = 4'b0001,
          setAn3 = 4'b0000;

reg[19:0] counter=0;
reg[3:0] state_counter=0;
reg clk_enable;


///create a signal , every 1μs , which allow to change states 
///according to a counter
///when rst==1 the systems is initialiazed

always @(posedge clk)
begin
   if(rst==1)
	begin
		counter =20'b0;
		
	end
	else
	begin
		counter = (counter>=100000)? 0 : (counter + 1'b1);
      clk_enable = (counter < 50000)?1'b0:1'b1;
   end
end


///always block with a case statement for every state of 
///this fsm(see truth table)
always @(posedge clk_enable)
	begin
	
	if(rst==1'b1)
		begin
			an0=1'b1;
			an1=1'b1;
			an2=1'b1;
			an3=1'b1;
			char = 4'b0;
			state_counter =4'b0000;
		end
	
		case(state_counter)
		
		prepAn3: 
			begin
				
				state_counter= state_counter - 1'b1;
			end
		openAn3: 
			begin
				an3 = 1'b0;
				state_counter = state_counter - 1'b1;
			end
		closeAn3: 
			begin
				an3 = 1'b1;
				state_counter= state_counter - 1'b1;
			end
		setAn2: 
			begin
				char=4'b0001;//set for anode2
				state_counter = state_counter - 1'b1;
			end
		prepAn2: 
			begin
				
				state_counter = state_counter - 1'b1;
			end
		openAn2: 
			begin
				an2 = 1'b0;
				state_counter = state_counter - 1'b1;
			end
		closeAn2: 
			begin
				an2 = 1'b1;
				state_counter = state_counter - 1'b1;
			end
		setAn1: 
			begin
				char=4'b0010;//set for anode1
				state_counter = state_counter - 1'b1;
			end
		prepAn1: 
			begin
				
				state_counter = state_counter - 1'b1;
			end
		openAn1: 
			begin
				an1 = 1'b0;
				state_counter = state_counter - 1'b1;
			end
		closeAn1: 
			begin
				an1 = 1'b1;
				state_counter = state_counter - 1'b1;
			end
		setAn0: 
			begin
				char=4'b0011;//set for anode0
				state_counter = state_counter - 1'b1;
			end
		prepAn0: 
			begin
				
				state_counter = state_counter - 1'b1;
			end
		openAn0: 
			begin
				an0 = 1'b0;
				state_counter = state_counter - 1'b1;
			end
		closeAn0: 
			begin
				an0 = 1'b1;
				state_counter = state_counter - 1'b1;
			end
		setAn3: 
			begin
				char=4'b0000;//set for anode3
				state_counter = state_counter - 1'b1;
			end
		endcase
	end

endmodule

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
//Initially all the anodes , the counter and the char have a value=x
//until the module is initialised(reset=1) with proper values
//
//TRUTH TABLE
// *  state/count  | an3 | an2 | an1 | an0 || char
//  -----------------------------------------------------------------
//        1111     |  1  |  1  |  1  |  1  ||  mem[indexAn3]  
//        1110     |  0  |  1  |  1  |  1  ||  mem[indexAn3]   
//        1101     |  1  |  1  |  1  |  1  ||  mem[indexAn3]   
//        1100     |  1  |  1  |  1  |  1  ||  mem[indexAn2]   <-set value(an2)
//        1011     |  1  |  1  |  1  |  1  ||  mem[indexAn2]  
//        1010     |  1  |  0  |  1  |  1  ||  mem[indexAn2]    
//        1001     |  1  |  1  |  1  |  1  ||  mem[indexAn2]     
//        1000     |  1  |  1  |  1  |  1  ||  mem[indexAn1]   <-set value(an1)  
//        0111     |  1  |  1  |  1  |  1  ||  mem[indexAn1]    
//        0110     |  1  |  1  |  0  |  1  ||  mem[indexAn1]    
//        0101     |  1  |  1  |  1  |  1  ||  mem[indexAn1]   
//        0100     |  1  |  1  |  1  |  1  ||  mem[indexAn0]   <-set value(an0)
//        0011     |  1  |  1  |  1  |  1  ||  mem[indexAn0]    
//        0010     |  1  |  1  |  1  |  0  ||  mem[indexAn0]    
//        0001     |  1  |  1  |  1  |  1  ||  mem[indexAn0]    
//        0000     |  1  |  1  |  1  |  1  ||  mem[indexAn3]   <-set value(an3)
//the index counters are increased only when we receive a posedge button
//and they take values from 0 to 15 
///////////////////////////////////////////////////////////////////////////////////

module FSM(clk,rst,btn,an3,an2,an1,an0,char);
input clk;
input btn;
input rst;
output reg an3;
output reg an2;
output reg an1;
output reg an0;
reg [3:0] tempAn3,tempAn2,tempAn1,tempAn0;
output reg[3:0] char=4'b0000;

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

reg[19:0] counter;
reg[3:0] state_counter;
reg [3:0] indexAn3,indexAn2,indexAn1,indexAn0;
reg [3:0] mem [0:15];
reg previous_button;
reg clk_enable;

always @(posedge clk)
	begin
   if(rst==1'b1)
	begin
		counter =20'b0000;
		previous_button = 1'b0;
		
		tempAn3=4'b0000; ///initializing pointer to mem for an3 in 0
		tempAn2=4'b0001; ///initializing pointer to mem for an2 in 1
		tempAn1=4'b0010; ///initializing pointer to mem for an1 in 2
		tempAn0=4'b0011; ///initializing pointer to mem for an0 in 3
		
		//clk_enable signal to triger the other always block
		//so as the anodes and the index registers to be initialized
		clk_enable=1'b1;
		
		///initialization of mem 
		mem[0]  = 4'b0000; 
		mem[1]  = 4'b0001;
		mem[2]  = 4'b0010;
		mem[3]  = 4'b0011;
		
		mem[4]  = 4'b0100; 
		mem[5]  = 4'b0101;
		mem[6]  = 4'b0110;
		mem[7]  = 4'b0111;

		mem[8]  = 4'b1000; 
		mem[9]  = 4'b1001;
		mem[10] = 4'b1010;
		mem[11] = 4'b1011;
	
		mem[12] = 4'b1100; 
		mem[13] = 4'b1101;
		mem[14] = 4'b1110;
		mem[15] = 4'b1111; 
	
	end
	
	else
		///10^(-8) or 10ns to 1ms (x10^5)
		begin 
			counter = (counter>=99999)? 1'b0 :counter + 1'b1;
			clk_enable = (counter < 50000)? 1'b0:1'b1;
			
			if(btn == 1'b1 && previous_button == 1'b0) 
				begin
				////mux in that case ensure that we will not access
				///memory pos that we do not use
					tempAn3 = (tempAn3 >= 4'b1111) ? 1'b0 : tempAn3 + 1'b1;
					tempAn2 = (tempAn2 >= 4'b1111) ? 1'b0 : tempAn2 + 1'b1;
					tempAn1 = (tempAn1 >= 4'b1111) ? 1'b0 : tempAn1 + 1'b1;
					tempAn0 = (tempAn0 >= 4'b1111) ? 1'b0 : tempAn0 + 1'b1;
					
				end
			
				previous_button = btn;
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
			state_counter=4'b0000;
			
			indexAn3=tempAn3;
			indexAn2=tempAn2;
			indexAn1=tempAn1;
			indexAn0=tempAn0;
		end
		
		else
		begin
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
				char=mem[indexAn2];//set for anode2
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
				char=mem[indexAn1];//set for anode1
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
				char=mem[indexAn0];//set for anode0
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
				indexAn3=tempAn3;  //temp variables is used to pass new
				indexAn2=tempAn2;  //values ONLY in the first stage of the 
				indexAn1=tempAn1;  //state_counter 
				indexAn0=tempAn0;
				
				
				char=mem[indexAn3];//set for anode3
				state_counter = state_counter - 1'b1;
			end	
		endcase
		end
	end

endmodule

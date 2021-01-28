`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:36:05 11/16/2020 
// Design Name: 
// Module Name:    uart_receiver 
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
module uart_receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD,
Rx_FERROR, Rx_PERROR, Rx_VALID);
input reset, clk;
input [2:0] baud_select;
input Rx_EN;
input RxD;
output reg [7:0] Rx_DATA = 8'b0;
output reg Rx_FERROR; // Framing Error //
output reg Rx_PERROR; // Parity Error //
output reg Rx_VALID; // Rx_DATA is Valid //

parameter IDLE_STATE = 2'b00,
          RECEIVING_STATE = 2'b01,
			 END_OF_RECEIVING_STATE = 2'b10,
			 END_OF_CHECKING_STATE  = 2'b11;

reg [1:0] nextState , currentState;
reg [3:0]receive_counter,data_counter;
reg start_bit , stop_bit , parity_bit;
reg [7:0] read_data;
reg take_sample_ENABLE;
reg Rx_DONE;
reg check_done;

baud_controller baudControllerIN(reset, clk, baud_select, Rx_sample_ENABLE);

//fsm
always @(reset or Rx_EN or RxD or start_bit or Rx_DONE or check_done)
begin
	if(reset)
		nextState = IDLE_STATE;
	else if(((Rx_EN  && !RxD) || (Rx_EN  && !start_bit)) && (!Rx_DONE) && (!check_done)) //start_bit initialized after 
		nextState = RECEIVING_STATE;
	else if(Rx_DONE && !check_done)
		nextState = END_OF_RECEIVING_STATE;
	else if(check_done)
		nextState = END_OF_CHECKING_STATE;
	else
		nextState = IDLE_STATE;
end

always @(nextState)
begin
	currentState = nextState;
end

//always block which generates the take_sample_ENABLE pulse
//in the middle of the transmissions's cycle in order to take more accurate samples
//transmission cycles = 16 x baud_sample_ENABLE
always @(posedge Rx_sample_ENABLE or posedge reset) 
begin
	if(reset)
		begin
			receive_counter = 4'b0;
			take_sample_ENABLE = 1'b0;
		end
	else if(Rx_EN)
		begin
			if(receive_counter==4'b1111) //initialization of receive_counter for the next bit
			begin
				receive_counter = 4'b0;
				take_sample_ENABLE = 1'b0;
			end
			else if(receive_counter==4'b1000)//generation of take_sample_ENABLE pulse for the purpose of sampling
			begin
				receive_counter = receive_counter + 1'b1;
				take_sample_ENABLE = 1'b1;
			end
			else
			begin
				receive_counter = receive_counter + 1'b1;
				take_sample_ENABLE = 1'b0;
			end
		end
	else
		begin
			receive_counter = 4'b0;
			take_sample_ENABLE = 1'b0;
		end
end

///DATA SAMPLING
always @(posedge take_sample_ENABLE or posedge reset)
begin
	if(reset)
	begin
		data_counter = 4'b0;
		start_bit=1'b1;
		stop_bit=1'b0;
		parity_bit=1'b1;
		Rx_DONE=1'b0;
		read_data = 8'b_0;
	end
	else if(((Rx_EN  && !RxD) || (Rx_EN  && !start_bit))  && !check_done) 
	begin
		case(data_counter)
			4'b0000 : 
			begin
				start_bit = RxD;
				Rx_DONE=1'b0;
				data_counter = data_counter + 1'b1;
			end
			4'b1001 : 
			begin
				parity_bit = RxD;
				Rx_DONE=1'b0;
				data_counter = data_counter + 1'b1;
			end
			4'b1010 :
			begin
				stop_bit = RxD;
				data_counter = 4'b0;
				Rx_DONE=1'b1;
			end
			default:
			begin
				read_data = {RxD, read_data[7:1]};
				data_counter = data_counter + 1'b1;
				Rx_DONE=1'b0;
			end
		endcase
	end
	else
		begin
			data_counter = 4'b0;
			start_bit=1'b1;
			stop_bit=1'b0;
			parity_bit=1'b1;
			Rx_DONE=1'b0;
		end
	
end


//assign data
always @(posedge Rx_VALID or posedge reset)
begin
	if(Rx_VALID)
		begin
			Rx_DATA = read_data;
		end
	else
		begin
			Rx_DATA = 8'b0;
		end
	
end

//check for error in parity bit AND
//for possible mistakes in frame transmission (start bit and stop bit)
always @(Rx_DONE or reset)
begin
	if(reset)
		begin
			Rx_PERROR = 1'b0;
			Rx_FERROR = 1'b0;
			Rx_VALID = 1'b0;
			check_done = 1'b0;
		end
	else if(Rx_DONE==1'b1) //Rx_DONE is used to inform the system that the whole data package have arrived
		begin			  //and we are ready to check it for possible mistakes
			Rx_PERROR = (parity_bit != ^read_data) ? 1'b1 : 1'b0;
		
			Rx_FERROR = ((start_bit != 1'b0) || (stop_bit != 1'b1)) ? 1'b1 : 1'b0;
		
			Rx_VALID = ((Rx_FERROR!=1'b1) && (Rx_PERROR!=1'b1)) ? 1'b1 : 1'b0;
			
			check_done = 1'b1; 
		end
	else
		begin
			Rx_PERROR = 1'b0;
			Rx_FERROR = 1'b0;
			Rx_VALID = 1'b0;
			check_done = 1'b0;
		end
end

endmodule
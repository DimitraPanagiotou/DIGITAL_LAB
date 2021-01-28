`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:54 11/10/2020 
// Design Name: 
// Module Name:    uart_transmitter 
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
////////////////////////////////////////////////////////////////////////////////////
///STATE | RESET | Tx_EN | Tx_WR | Tx_BUSY | start_transmission | transmission_ended 
///  00  |   1   |   0   |   0   |    0    |          0         |          0
///  01  |   0   |   1   |   1   |    0    |          1         |          0     
///  10  |   0   |   1   |   0   |    1    |          1         |          0
///  11  |   0   |   1   |   0   |    0    |          0         |          1
/////////////////////////////////////////////////////////////////////////////////////
module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);
input reset, clk;
input [7:0] Tx_DATA;
input [2:0] baud_select;
input Tx_EN;
input Tx_WR;
output reg TxD;
output reg Tx_BUSY;



parameter IDLE_STATE = 2'b00,
          ACTIVE_TRANSMITTER_STATE = 2'b01,
			 TRANSMISSION_STATE = 2'b10,
			 END_OF_TRANSMISSION_STATE  = 2'b11;

reg start_transmission;
reg ready_data; 
reg assign_data_signal;
reg data_assigned=0;
wire Tx_sample_ENABLE;
reg transmit_ENABLE;
reg[1:0] nextState,currentState;
reg[10:0] data_to_send;
reg [3:0] index_data,transmit_counter;
reg transmission_ended;

baud_controller baud_controller_instance(reset, clk, baud_select, Tx_sample_ENABLE);



//control unit
//given the signals value 
always@(Tx_EN or Tx_WR or start_transmission or transmission_ended or reset)
begin
	if(reset)
	begin
		nextState=IDLE_STATE;
	end
	else if(Tx_EN && Tx_WR==1'b0 && start_transmission==1'b0 && transmission_ended==1'b0)//it checks if the transmitter is active 																										//assign_data_signal is raised every
	begin						 														
		nextState=ACTIVE_TRANSMITTER_STATE;																		
	end
	else if((start_transmission==1'b1  && transmission_ended==1'b0) || (Tx_WR)) 
	begin														//the data are transmitted
		nextState=TRANSMISSION_STATE;
	end
	else if(transmission_ended==1'b1) //a check signal for the end of transmission , if that signal have arrived
	begin										 //we initialize the system for the next data
		nextState=END_OF_TRANSMISSION_STATE;
	end
	else
	begin
		nextState=IDLE_STATE;
	end
end

//assign next state value
always @(nextState)
begin
	currentState = nextState;
end


//always block with main purpose to give the appropriate signal for the transmission
//start_transmission begin the transmission process
always @ (currentState)
begin
	case(currentState)
		TRANSMISSION_STATE:
			start_transmission = 1'b1;
		default:
			start_transmission = 1'b0;
	endcase
end


//set the data buffer
always @ (posedge Tx_WR)
begin
		data_to_send[0] = 1'b0;
		data_to_send[1] = Tx_DATA[0];
		data_to_send[2] = Tx_DATA[1];
		data_to_send[3] = Tx_DATA[2];
		data_to_send[4] = Tx_DATA[3];
		data_to_send[5] = Tx_DATA[4];
		data_to_send[6] = Tx_DATA[5];
		data_to_send[7] = Tx_DATA[6];
		data_to_send[8] = Tx_DATA[7];
		data_to_send[9] = ^Tx_DATA;
		data_to_send[10] = 1'b1;

end

//every 16 sample pulses create a transmit_ENABLE pulse
always @(posedge Tx_sample_ENABLE or  posedge reset) 
begin
	if(reset==1'b1)
	begin
		transmit_counter = 4'b0;
		transmit_ENABLE = 1'b0;
	end
	else if(Tx_EN)
	begin
		if(transmit_counter==4'b1111)
		begin
			transmit_counter = 4'b0;
			transmit_ENABLE = 1'b1;
		end
		else
		begin
			transmit_counter = transmit_counter + 1'b1;
			transmit_ENABLE = 1'b0;
		end
	end
	else
	begin
		transmit_ENABLE = 1'b0;
		transmit_counter = 4'b0;
	end
end


// THE TRANSMISSION CONTROL UNIT
//it checks if data have already been assigned and then transmit them
//different it transmits 1
always @(posedge transmit_ENABLE or posedge reset) 
begin
	if(reset==1'b1)
	begin
		TxD = 1'b1;
		Tx_BUSY=1'b0;
		index_data= 4'b0000;
		transmission_ended=1'b0;
	end
	else if(start_transmission)
	begin
		if(index_data == 4'b1011)
		begin
			Tx_BUSY=1'b0;
			TxD = 1'b1;
			index_data = 4'b0000;
			transmission_ended=1'b1;
		end
		else
			begin  // data transmission (start bit, data, parity bit, end bit)
				Tx_BUSY=1'b1;
				TxD = data_to_send[index_data];    // in total: 11 bits
				index_data = index_data + 1'b1;
				transmission_ended=1'b0;
			end
		end
	else
	begin	
			index_data = 4'b0000; ///initialization for next input
			Tx_BUSY=1'b0;
			TxD = 1'b1;
			transmission_ended=1'b0;
	end
end
	
	
endmodule

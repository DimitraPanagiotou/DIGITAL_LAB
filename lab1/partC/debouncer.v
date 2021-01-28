`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:52 10/28/2020 
// Design Name: 
// Module Name:    debouncer 
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
//debouncer module implements a controler
//for the minimun pulse duration in order
//to avoid small pulses(which are caused due to noise) 
/////////////////////////////////////////////////////////////////////////////////
module debouncer #(parameter DELAY=250000)   // 2.5 msec with a 100 Mhz clock
	             (input rst,
					 input clk,
					 input noise, 
					 output reg clean);
	              
   reg [19:0] counter='d0;
	reg check;
	///check if rst is up(if so stay in initial state)
	//else check if there is pulse(if so increase the counter until
	//we reach the DELAY value and then raise the pulse for our new debounced signal)
	//when the input noise signal goes down decrease the counter(and keep the new debounced signal
	//up until the counter reaches 0)
    always @ (posedge clk)
        begin
            if(rst == 1'b1)
                begin
                    counter = 20'b0;
                    clean = 1'b0;
						  check=1'b0;
                end
            else 
                begin
                    if(noise == 1'b0)
                        begin
									 if(counter != 1'b0 && clean==1'b1)  ///checks if the pulse is raised									 
									 begin										 ///and if so we keep the pulse raised
										clean = 1'b1;							 ///until the counter reach the 0
										counter = counter - 1'b1;
									 end
									 else
									 begin
										clean = 1'b0;
										counter = 20'b0;
									 end
								end
                    else
                        begin
                            if(counter == DELAY-1)					///check the counter value and then raise the pulse
                                begin
                                   clean = 1'b1;	
                                end 
									 else
										  begin
											  if(clean==1'b1 )             ///if noise is 1 and pulse is already raised we keep 
											  begin								///the pulse raised and the counter value stable
													if(counter==0)
													begin
														clean=1'b0;
														counter = 20'b0;
													end
													else
													begin
														clean=1'b1;
														counter = counter - 1'b1;
													end
											  end
											  else
											  begin
													clean = 1'b0;
													counter=counter+1'b1;
											  end
										  end
										
                        end
                end
        end
endmodule



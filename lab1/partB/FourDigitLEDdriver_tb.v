`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:53:06 10/23/2020
// Design Name:   FourDigitLEDdriver
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partB/FourDigitLEDdriver_tb.v
// Project Name:  partB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FourDigitLEDdriver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FourDigitLEDdriver_tb;

	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire an3;
	wire an2;
	wire an1;
	wire an0;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
	wire dp;

	// Instantiate the Unit Under Test (UUT)
	FourDigitLEDdriver uut (
		.reset(reset), 
		.clk(clk), 
		.an3(an3), 
		.an2(an2), 
		.an1(an1), 
		.an0(an0), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.dp(dp)
	);
	integer i=0,error=0;
	reg [6:0]temp=0;
	reg [4:0]counter=0;
	reg [1:0]cycle=0;
	
	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#10 reset = 1;
		
		
		for(i=0;i<'d60000000;i=i+1)
		begin
			#5 clk=~clk;
		end
		
		reset=1'b0;
		
		
		
		for(i=0;i<'d50000000;i=i+1)
		
		begin
		#5 clk=~clk;
		//$display("ff\n");
		///initialize rst
		
		
		if(clk==1'b1)
		begin
	
			
		if(reset==1'b0)
		begin
			
				if(counter==100000)
				begin
					
					case(cycle)
					2'b00:
						begin
						  //$display("%d LED VALUE %b%b%b%b%b%b%b",i,a,b,c,d,e,f,g);
							cycle=cycle+1;
						end
						2'b01:
						begin
							cycle=cycle+1;
						end
						2'b10:
						begin
							//$display("when an0:%b    an1:%b    an2:%b    an3:%b",an0,an1,an2,an3);
							cycle=cycle+1;
							//////correct answers
							temp[6]=a;
							temp[5]=b;
							temp[4]=c;
							temp[3]=d;
							temp[2]=e;
							temp[1]=f;
							temp[0]=g;
							
							case(temp)
								7'b0000110: 
									begin
									error = (an0) ? error+1 : error;
									if(an0!=0)begin
									$display("***********************************");
									$display("ERROR: at %d expected an0 = 0 and an0=%b		an1=%b   an2=%b		an3=%b",i,an0,an1,an2,an3);
									$display("***********************************");
									end
									end
								7'b0010010: 
									begin
									error = (an1) ? error+1 : error;
									if(an1!=0)begin
									$display("***********************************");
									$display("ERROR: at %d expected an1 = 0 and an0=%b  an1=%b   an2=%b		an3=%b",i,an0,an1,an2,an3);
									$display("***********************************");
									end
									end
								7'b1001111: 
									begin
									error = (an2) ? error+1 : error;
									if(an2!=0)begin
									$display("***********************************");
									$display("ERROR: at %d expected an2 = 0 and an0=%b   an1=%b		an2=%b	an3=%b",i,an0,an1,an2,an3);
									$display("***********************************");
									end
									end
								7'b0000001: 
									begin
									error = (an3) ? error+1 : error;
									if(an3!=0)begin
									$display("***********************************");
									$display("ERROR: at %d expected an3 = 0 and an0=%b   an1=%b		an2=%b	an3=%b",i,an0,an1,an2,an3);
									$display("***********************************");
									end
									end
							endcase
							
						end
						2'b11:
						begin
						  //$display("\n");
							cycle=0;
						end
					endcase
					counter=0;
					
				end
				else
				begin
					counter=counter+1;
				end
			end
			else
			begin
				cycle=0;
				counter='d0;
			end
		end
		end  
		$display("Test finished. Found %0d Errors!",error);

	end
      
	
endmodule


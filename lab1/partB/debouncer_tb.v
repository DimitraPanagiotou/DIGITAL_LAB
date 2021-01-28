`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:04:53 10/22/2020
// Design Name:   debouncer
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment1/partB/debouncer_tb.v
// Project Name:  partB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debouncer_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire clean_rst;

	// Instantiate the Unit Under Test (UUT)
	debouncer uut (
		.clk(clk), 
		.rst(rst), 
		.clean_rst(clean_rst)
	);
	integer i=0;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
  
		// Add stimulus here
		//case 1
		//test for multiple reset alternations in 1 clock cycle
		
		#5 rst =1;
		#10 rst=~rst;
		#10 rst=~rst;
		#10 rst=~rst;
		#5 rst =~rst;
		#10 rst=~rst;
		#10 rst=~rst;
		#10 rst=~rst;
		#5 rst =~rst;
		#10 rst=~rst;
		#10 rst=~rst;
		
		
		
		
		
		//case 2
		//test for stable reset for more than MIN clock cycles 
		
		#100 clk=~clk;
		
		for(i=0;i<'d20;i=i+1)
		begin
		#10
		clk=~clk;
		end 
		rst=~rst;
		i=0;
		for(i=0;i<'d20;i=i+1)
		begin
		#10
		clk=~clk;
		rst=~rst;
		
		end 
	
	//case 3
	//test for (min time) posedge clock - negedge reset
		#80 clk=~clk;
		#20 rst=~rst;
		
		#50 clk=~clk;
		#50 clk=~clk;
		#50 clk=~clk;
		#50 clk=~clk;
		#50 clk=~clk;//MIN POSEDGE CLOCK
		rst=~rst;
		#50 clk=~clk;
		#50 clk=~clk;
		
	//case 4
	//test for (min time+1) posedge clock - negedge reset
		#80 clk=~clk;
		#20 rst=~rst;
		
		#50 clk=~clk;
		#50 clk=~clk;
		#50 clk=~clk;
		#50 clk=~clk;
		#50 clk=~clk;//MIN POSEDGE CLOCK
		#50 clk=~clk;
		#50 clk=~clk;
		rst=~rst;
		
	end
      
endmodule


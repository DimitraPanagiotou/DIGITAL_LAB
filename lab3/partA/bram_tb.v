`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:53:12 12/02/2020
// Design Name:   bram
// Module Name:   C:/Users/Dimitra/Desktop/ECE333/assignment3/partA/bram_tb.v
// Project Name:  partA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bram_tb;

	// Inputs
	reg clk;
	reg reset;
	reg en;
	reg [13:0] address;

	// Outputs
	wire red;
	wire green;
	wire blue;

	// Instantiate the Unit Under Test (UUT)
	bram uut (
		.clk(clk), 
		.reset(reset), 
		.en(en), 
		.address(address), 
		.red(red), 
		.green(green), 
		.blue(blue)
	);
	reg final_check=1'b0;
	integer i,j,err = 0;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		en = 0;
		address = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=1'b1;
		
		#100;
		reset=1'b0;
		en=1'b1;
        
		// Add stimulus here
		
		
		//blue color
		#20;
		address='d3072;
		$display("expected blue R: 0 | G: 0 | B: 1");
		for(i='d3072;i<'d6144;i=i+1)
		begin	
			#20 address = address + 1;
			if(red != 1'b0 && green != 1'b0 && blue != 1'b1)
			begin
				final_check=1'b1;
				err = err+1;
			end
		end
		$display("BLUE:found %d errors",err);
		
		#1000;
		err=0;
		
		//green color
		#20
		address = 'd6144;
		$display("expected green R: 0 | G: 1 | B: 0");
		for(i='d6144;i<'d9215;i=i+1)
		begin	
			#20 address = address + 1;
			if(red != 1'b0 && green != 1'b1 && blue != 1'b0)
			begin
				final_check=1'b1;
				err = err+1;
			end
		end
		$display("GREEN:found %d errors",err);
		#1000;
		err=0;
		
		
		//red color
		#20;
		address='d0;
		$display("expected red R: 1 | G: 0 | B: 0");
		for(i='d0;i<'d3071;i=i+1)
		begin	
			#20 address = address + 1;
			if(red != 1'b1 && green != 1'b0 && blue != 1'b0)
			begin
				final_check=1'b1;
				err = err+1;
			end
		end
		$display("RED:found %d errors",err);
		#1000;
		err=0;
		
		
		//multicolor color
		#20;
		address = 9216;
		$display("check for multiple colors");
		for(i='d0;i<'d24;i=i+1)
		begin	
			for(j='d0;j<'d128;j=j+1)
			begin
				#20 address = address + 1;

				//$display("j %d expected blue R: %d | G: %d | B: %d",j,red,green,blue);
				if(j>='d0 && j<=27)
				begin
					err = (red != 1'b1 && green != 1'b0 && blue != 1'b1) ? err+1 : err;  //purple
				end
				else if(j>='d28 && j<=49)
				begin
					err = (red != 1'b1 && green != 1'b1 && blue != 1'b1) ? err+1 : err;  //white
				end
				else if(j>='d50 && j<=77)
				begin
					err = (red != 1'b1 && green != 1'b1 && blue != 1'b0) ? err+1 : err;  //light blue
				end
				else if(j>='d78 && j<=99)
				begin
					err = (red != 1'b0 && green != 1'b0 && blue != 1'b0) ? err+1 : err;  //black
				end
				else if(j>='d100 && j<=127)
				begin
					err = (red != 1'b0 && green != 1'b1 && blue != 1'b1) ? err+1 : err;  //yellow
				end
				
			end
		end
		$display("MULTICOLOR:found %d errors",err);
		
		#1000;
		err=0;
		
		
	
		
		//final check
		if(final_check == 1'b0)
		begin
			$display("****************************");
			$display("****************************");
			$display("***COMPLETED SUCCESFULLY***");
			$display("****************************");
			$display("****************************");
		end
		else
			$display("FOUND ERRORS");
		
		#1000;
	end
	
	always
		#5 clk=~clk;
      
endmodule


`timescale 1ns / 1ps
module LEDdecoder(char, LED);
input [3:0] char;
output reg [6:0] LED;

always @(char)
   begin
    case(char)
				4'b0000:
						begin
						  LED = 7'b0000001;   //0
						end
				4'b0001:
						begin
						  LED = 7'b1001111;   //1
						end
				4'b0010:
						begin
						  LED = 7'b0010010;   //2
						end
				4'b0011:
						begin
						  LED = 7'b0000110;   //3
						end
				4'b0100:
						begin
						  LED = 7'b1001100;   //4
						end
				4'b0101:
						begin
						  LED = 7'b0100100;   //5
						end
				4'b0110:
						begin
						  LED = 7'b0100000;   //6
						end
				4'b0111:
						begin
						  LED = 7'b0001111;   //7
						end
				4'b1000:
						begin
						  LED = 7'b0000000;   //8
						end
				4'b1001:
						begin
						  LED = 7'b0000100;   //9
						end
				4'b1010:
						begin
						  LED = 7'b0001000;  //a
						end
				4'b1011:
						begin
						  LED = 7'b1100000;   //b
						end
				4'b1100:
						begin
						  LED = 7'b0110001;   //c
						end
				4'b1101:
						begin
						  LED = 7'b1000010;   //d
						end
				4'b1110:
						begin
						  LED = 7'b0110000;   //e
						end	
				4'b1111:
						begin
						  LED = 7'b0111000;   //f
						end
				default:
				        begin
				          LED = 7'b1000000;
				        end
			endcase
			
        //numbers= ~numbers;
   end

endmodule

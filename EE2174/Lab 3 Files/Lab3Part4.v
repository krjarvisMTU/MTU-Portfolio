/*
Author: Kyle Jarvis
Program Name: Lab 3 Part 4
Creation Date: 1/31/24
Date Last Updated: 1/31/24
Function: A*C+C*D
Method: uses only Nand gates 
Inputs: sw0-3
Outputs: LEDR[2]
Comments:
*/

module Lab03Part4(
input [3:0] SW,
output reg[2:0] LEDR);

always@(SW)
	begin
	
	LEDR[2]= ~(~(SW[0] & SW[1]) & ~(SW[2] & SW[3]));
	
	end

endmodule
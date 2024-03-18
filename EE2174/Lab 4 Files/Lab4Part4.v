/*
Author: Kyle Jarvis
Program Name: Lab 4 Part 4
Creation Date: 2/7/24
Date Last Updated: 2/7/24
Function: Counts clock cycles and shows them increasing on HEX0
Method: Counts clock cycles
Inputs: CLOCK_50
Outputs: LEDR[9:0]
Comments:
*/

module Lab4Part4(
input CLOCK_50,
output [6:0] HEX0);


reg [32:0] count;
reg [3:0] value;
parameter X = 50000000;

 

always @(posedge CLOCK_50)

	begin
	
	count = count + 1;
 
		if(count == X)
		
		begin
		
			count = 0;
			value = value + 1;
			
		end

	end

	hex7seg instanceName1(.num (value), .display (HEX0));

endmodule
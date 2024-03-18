/*
Author: Kyle Jarvis
Program Name: Lab 4 Part 1
Creation Date: 2/7/24
Date Last Updated: 2/7/24
Function: Periodic Clock Program
Method: Using increments for the LEDR
Outputs: DE10 Board
*/

module Lab4Part1(
input CLOCK_50,
output reg[9:0] LEDR);

	reg[32:0] count;
	parameter X = 50000000;
	
	// Evaluate on positive (rising) edges of the clock
	always @(posedge CLOCK_50)
	begin
	
		// Increment count if count is equal to maxium value (X),
		// resets counts value and increment the LED vector
		// Behavior: LEDR will increment every (X) clock cycles
		count = count + 1;
		
		if (count == X)
		begin
			count = 0;
			LEDR = LEDR + 1;
		end
	
	end
	
endmodule

/*
Author: Kyle Jarvis
Program Name: Lab7Test1
Creation Date: 3/13/24
Date Last Updated: 3/13/24
Function: Tests multiple outputs of the CarryLogic and then output them to waeform
Method: uses a for loop to loop through different inupts then runs them through the function
Inputs:
Outputs: C
Comments:
*/

// Test bench file for testing equations C3 and C4
// using all 4 bit G and P input combinations
module Lab07Test1(
output [2:1] C);
	
	// 8-bit value used to increment P and G input values
	reg [3:0] testInput;		// 2^8 = 256 test values
	integer k;					// k int for loop variable

	reg [1:0] P, G;			// 4-bit input variables
	
	// Testing 4-bit carry look-ahead logic module
	CarryLogic DUT(.P(P), .G(G), .C(C));
	
	initial
	begin
		// Initialize testInput variable to 0
		testInput = 4'b0;
		// Loop 256 times
		for(k = 0; k < 16; k = k + 1)
		begin
			
			{P, G} = testInput;	// Concatenation Notation
			// P = testInput [7:4], G = testInput [3:0]
			
			#10; 						// Wait 10 clock units
			
			// Increment testInput once per loop
			testInput = testInput + 1;
		
		end
	end

endmodule
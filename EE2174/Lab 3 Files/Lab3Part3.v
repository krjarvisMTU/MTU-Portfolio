/*
Author: Kyle Jarvis
Program Name: Lab 3 Part 3
Creation Date: 1/31/24
Date Last Updated: 1/31/24
Function: Gate level AND/OR
Method: Using outputs and inputs to not use AND/Or
Outputs: DE10 Board
*/

module Lab3(
	input [3:0] SW,
	output[2:0] LEDR);
	// The first three LEDs will be used in this lab
	
	
		// Temporary variables used to allow the flow of data values
		// Rather than storing the value to be used later
		
		wire a, b;
		
		// gate_name (Output, Input1, Input2, Input3,...);
		// LEDR[0] = SW[0]&SW[1] | SW[2]&SW[3]
		
		nand(a, SW[0], SW[1]);	// a = SW[0] nand SW[1]
		nand(b, SW[2], SW[3]);	// b = SW[2] nand SW[3]
		nand(LEDR[1], a, b);		// LEDR[0] = a nand b

endmodule


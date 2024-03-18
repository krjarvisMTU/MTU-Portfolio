/*
Author: Kyle Jarvis
Program Name: Lab 5 Part 1
Creation Date: 2/21/24
Date Last Updated: 2/21/24
Function: Functions as a half adder
Method: adds two numbers together using boolean logic. 
Inputs: SW
Outputs: LEDR
Comments:
*/

module Lab5Part1(
input [1:0] SW,
output [1:0] LEDR);


	
	
	//impliments half adder and inputs the switches
	HA halfadder1(.A(SW[0]), .B(SW[1]), .Co(LEDR[1]), .S(LEDR[0]));
	
	
	

endmodule


module HA(
input A, B,
output Co, S);

   //compleate SOP equation for the sum bit
   assign S = A^B; 

   //compleate SOP equation for the carry out bit
   assign Co = A&B;

endmodule

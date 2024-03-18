/*
Author: Kyle Jarvis
Program Name: Lab 5 Part 2
Creation Date: 2/21/24
Date Last Updated: 2/21/24
Function: Functions as a full adder
Method: adds two numbers together using boolean logic, then displays them on LEDR[1:0]
Inputs: A, B, Cin
Outputs: Co, S
Comments: 
*/


module Lab5Part2(
input [2:0]SW,
output [1:0]LEDR);

	//impliments half adder and inputs the switches
	FA fulladder1(.A(SW[1]), .B(SW[2]), .Cin(SW[0]), .Co(LEDR[1]), .S(LEDR[0]));

endmodule


module FA(
input A, B, Cin,
output Co, S);


   // complete SOP equation for the sum bit
   assign S = A^B^Cin ;


   //complete SOP equation for the sum bit
   assign Co = (A&B) | (A&Cin) | (B&Cin);

endmodule
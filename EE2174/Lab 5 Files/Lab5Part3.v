/*
Author: Kyle Jarvis
Program Name: Lab 5 Part 3
Creation Date: 2/21/24
Date Last Updated: 2/21/24
Function: Functions as a 4-bit ripple carry adder
Method: adds numbers together using boolean expressions and by instancing a fulladder module, then displays number as a HEX output and on the LEDR
Inputs: SW
Outputs: LEDR
Comments:
*/


module Lab5Part3(
input [7:0]SW,
output [4:0]LEDR,
output [6:0]HEX0, HEX1);

//define wires to help link fulladdeers together
wire Cin1, Cin2, Cin3;

	//impliments full adder and inputs the switches
	FA fulladder1(.A(SW[0]), .B(SW[4]), .Cin(0), .Co(Cin1), .S(LEDR[0]));
	
	FA fulladder2(.A(SW[1]), .B(SW[5]), .Cin(Cin1), .Co(Cin2), .S(LEDR[1]));
	
	FA fulladder3(.A(SW[2]), .B(SW[6]), .Cin(Cin2), .Co(Cin3), .S(LEDR[2]));
	
	FA fulladder4(.A(SW[3]), .B(SW[7]), .Cin(Cin3), .Co(LEDR[4]), .S(LEDR[3]));
	
	
	hex7seg sevseg0(.num(LEDR[3:0]), .display(HEX0));
	
	hex7seg sevseg1(.num(LEDR[4]), .display(HEX1));


endmodule


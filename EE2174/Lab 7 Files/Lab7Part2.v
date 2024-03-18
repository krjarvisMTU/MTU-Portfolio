/*
Author: Kyle Jarvis
Program Name: Lab7Part2
Creation Date: 3/12/24
Date Last Updated: 3/12/24
Function: Impliments a 2 bit Carry-look ahead module
Method: instances SPG twice then feeds that into Cary Logic
Inputs:SW
Outputs: LEDR
Comments:
*/

module Lab07Implimentation(
input [3:0] SW, 
output [3:0] LEDR);

wire Sum1;
wire [1:0] G;
wire [1:0] P;
wire [2:1] C; 

SPG instance1(.A(SW[0]), .B(SW[2]), .Cin(0), .G(G[0]), .P(P[0]), .S(LEDR[0]));
SPG instance2(.A(SW[1]), .B(SW[3]), .Cin(C[1]), .G(G[1]), .P(P[1]), .S(LEDR[1]));



CarryLogic(.G(G), .P(P), .C(C));

assign LEDR[2] = C[2];

endmodule

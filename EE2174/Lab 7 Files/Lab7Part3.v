/*
Author: Kyle Jarvis
Program Name: Lab7Part3
Creation Date: 3/12/24
Date Last Updated: 3/12/24
Function: Impliments a 4 bit carry lookahead module, outputs sum to LEDR and HEX0,1
Method: uses 4 instances of SPG and one instance of Carry logic, outputs this to the LEDR and HEX0,1
Inputs:SW
Outputs: LEDR, HEX0, HEX1
Comments:
*/

module Lab07Implimentation2(
input [7:0] SW, 
output [4:0] LEDR,
output [6:0] HEX0, HEX1);

wire Sum1;
wire [3:0] G;
wire [3:0] P;
wire [4:1] C; 

SPG instance1(.A(SW[0]), .B(SW[4]), .Cin(0), .G(G[0]), .P(P[0]), .S(LEDR[0]));

SPG instance2(.A(SW[1]), .B(SW[5]), .Cin(C[1]), .G(G[1]), .P(P[1]), .S(LEDR[1]));

SPG instance3(.A(SW[2]), .B(SW[6]), .Cin(C[2]), .G(G[2]), .P(P[2]), .S(LEDR[2]));

SPG instance4(.A(SW[3]), .B(SW[7]), .Cin(C[3]), .G(G[3]), .P(P[3]), .S(LEDR[3]));


hex7seg pepe1(.num(LEDR[3:0]), .display(HEX0));
hex7seg pepe2(.num(LEDR[4]), .display(HEX1));

CarryLogic(.G(G), .P(P), .C(C));



assign LEDR[4] = C[4];

endmodule

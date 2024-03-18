/*
Author: Kyle Jarvis
Program Name: CarryLogic
Creation Date: 3/12/24
Date Last Updated: 3/12/24
Function: 
Method: 
Inputs:
Outputs: 
Comments: 
*/

module CarryLogic(
input [3:0]G, P,
output [4:1]C);

assign C[1] = G[0];
assign C[2] = G[1] | (P[1] & G[0]);
assign C[3] = G[2] | (P[2] & (G[1] | (P[1] & G[0])));
assign C[4] = G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & G[0])))));


endmodule
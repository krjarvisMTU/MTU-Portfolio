/*
Author: Kyle Jarvis
Program Name: FA
Creation Date: 2/21/24
Date Last Updated: 2/21/24
Function: Functions as a 4-bit ripple carry adder
Method: adds numbers together using boolean expressions and by fulladder
Inputs: A,B,Cin
Outputs: Co,S
Comments:
*/

module FA(
input A, B, Cin,
output Co, S);


   // complete SOP equation for the sum bit
   assign S = A^B^Cin ;


   //complete SOP equation for the sum bit
   assign Co = (A&B) | (A&Cin) | (B&Cin);

endmodule

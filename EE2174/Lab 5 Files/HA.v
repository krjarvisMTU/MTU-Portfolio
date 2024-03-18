/*
Author: Kyle Jarvis
Program Name: HA
Creation Date: 2/21/24
Date Last Updated: 2/21/24
Function: Functions as halfadder
Method: adds numbers together using boolean expressions and by halfadder
Inputs: A,B
Outputs: Co,S
Comments:
*/

module HA(
input A, B,
output Co, S);

   //compleate SOP equation for the sum bit
   assign S = A^B; 

   //compleate SOP equation for the carry out bit
   assign Co = A&B;

endmodule

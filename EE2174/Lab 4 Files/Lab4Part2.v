/*
Author: Kyle Jarvis
Program Name: Lab 4 Part 2
Creation Date: 2/7/24
Date Last Updated: 2/7/24
Function: Allows controll over the first HEX from the first 4 SW
Method: Assigns each switch a binary position and outputs the value to HEX0
Inputs: SW
Outputs: HEX0
Comments:
*/

module Lab4Part2(

input [3:0]SW,

output wire[6:0] HEX0);


hex7seg instanceName(.num (SW), .display (HEX0));
 

endmodule

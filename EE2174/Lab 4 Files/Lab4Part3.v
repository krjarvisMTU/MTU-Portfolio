/*
Author: Kyle Jarvis
Program Name: Lab 4 Part 3
Creation Date: 2/7/24
Date Last Updated: 2/7/24
Function: Allows controll over the first 2 HEX from the first 8 SW
Method: Assigns each switch a binary position and outputs the value to HEX
Inputs: SW
Outputs: HEX0, HEX1
Comments:
*/

module Lab4Part3(

input [7:0]SW,

output wire[6:0] HEX0, HEX1);


hex7seg instanceName1(.num (SW[3:0]), .display (HEX0));

hex7seg instanceName2(.num (SW[7:4]), .display (HEX1));
 

endmodule

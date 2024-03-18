/*
Author: Kyle Jarvis
Program Name: Lab 6 Part 1
Creation Date: 3/6/24
Date Last Updated: 3/6/24
Function: Runs the negative module and displays the value of it on a seven segment display
Method: passes in the value of a switch into the negative module, then assigns the output to a seven segment display.
Inputs: SW
Outputs:[6:0]HEX0
Comments:
*/

module Lab6Part1(
input [0:0]SW,
output [6:0]HEX0);


//Calls the negative module then outputs the value to a HEX display
Negative instance1(.sel(SW), .out(HEX0));


endmodule
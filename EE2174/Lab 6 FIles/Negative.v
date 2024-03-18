/*
Author: Kyle Jarvis
Program Name: Negative
Creation Date: 3/6/24
Date Last Updated: 3/6/24
Function: Converts a single value to a 7 bit binary number that can be represented on a HEX
Method: if the input is equeal to 1, all but the middle display will turn off
Inputs: sel
Outputs: out, 7 bits wide
Comments:
*/

module Negative(
input [0:0]sel,
output reg [6:0]out);


always@(sel)
	begin
//sets display to show negative
	if(sel == 1)
	begin
		out = 7'b0111111;
	end
 //sets display to show nothing
   else
	begin
		out = 7'b1111111;
	end

end

endmodule

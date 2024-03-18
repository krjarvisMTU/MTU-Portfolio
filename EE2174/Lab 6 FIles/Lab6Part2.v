/*
Author: Kyle Jarvis
Program Name: Lab 6 Part 2
Creation Date: 3/6/24
Date Last Updated: 3/6/24
Function: outputs twos compliment values to the seven segment display 
Method: calculates if the value inputted is negatve, if it is the value is converted by flipping the bits and adding one. 
Inputs: [7:0]SW
Outputs:[6:0]HEX0, HEX1, HEX2
Comments:
*/

module Lab6Part2(
input [7:0]SW,
output [6:0]HEX0, HEX1, HEX2);

reg [7:0]twosComp;

always@(SW)
	begin
	
	if(SW[7] == 1)
		begin
			twosComp = ~SW[7:0]+1'b1;
		end
	
	else
		begin
			twosComp = SW[7:0];
		end
	
	end


//Displays negative value if needed on HEX2
Negative instance1(.sel(SW[7]), .out(HEX2));

//Displays values on the seven segment display unsing hex7seg module
hex7seg instance3(.num(twosComp[3:0]), .display(HEX0));
hex7seg instance4(.num(twosComp[7:4]), .display(HEX1));


endmodule
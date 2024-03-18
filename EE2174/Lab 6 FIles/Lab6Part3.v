/*
Author: Kyle Jarvis
Program Name: Lab 6 Part 3
Creation Date: 3/6/24
Date Last Updated: 3/6/24
Function: Uses the internal clock to count up in hex values then display them on the hex.
Method: Evaluates rising edge of clock and compares to known value in order to have a counting variable.
Inputs: CLOCK_50
Outputs:[6:0]HEX0, HEX1, HEX2
Comments: hehe
*/

module Lab6Part3(
input CLOCK_50,
output [6:0]HEX0, HEX1, HEX2);


reg [30:0] count;
parameter X = 10000000;

reg [7:0] hexNum;
reg [7:0] twosComp;
 

always @(posedge CLOCK_50)
	begin

count = count + 1;
 

		if(count == X)
	begin
		count = 0;
	hexNum = hexNum + 1'b1;
	end
	
	if(hexNum[7] == 1)
		begin
			twosComp = ~hexNum[7:0]+1'b1;
		end
	
	else
		begin
			twosComp = hexNum[7:0];
		end
end


//Displays negative value if needed on HEX2
Negative instance1(.sel(hexNum[7]), .out(HEX2));

//Uses hex7seg module to display values on the HEX
hex7seg instance3(.num(twosComp[3:0]), .display(HEX0));
hex7seg instance4(.num(twosComp[7:4]), .display(HEX1));


endmodule




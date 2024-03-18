/*
Author: Kyle Jarvis
Program Name: Lab 6 Test
Creation Date: 3/6/24
Date Last Updated: 3/6/24
Function: tests Lab 6 code
Method: Passes in binary numbers then records waveform 
Inputs: XX
Outputs: f
Comments:
*/

module Lab6Test(
output [3:0] f);

reg [7:0] SW;

Lab6Part4 DUT(.SW(SW), .LEDR(f));

initial
begin

//Adding two posotive numbers
SW[7:4] = 4'b0001;
SW[3:0] = 4'b0101;

#10;

SW[7:4] = 4'b1001;
SW[3:0] = 4'b0101;

#10;

SW[7:4] = 4'b1001;
SW[3:0] = 4'b1101;

#10;

SW[7:4] = 4'b1000;
SW[3:0] = 4'b1000;

#10;
end
endmodule 
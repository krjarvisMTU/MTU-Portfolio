/*
Author: Kyle Jarvis
Program Name: Lab 6 Part 4
Creation Date: 3/6/24
Date Last Updated: 3/6/24
Function: takes in two 4 bit binary values and adds or subtracts them, then displays the result on the seven segment display. 
Method: Uses the instancing of a full adder to sum the values
Inputs: [7:0]SW
Outputs:HEX0, HEX1, [3:0]LEDR
Comments:
*/

module Lab6Part4(
input [7:0]SW,
output [6:0]HEX0, HEX1,
output [3:0]LEDR);

assign A = SW[3:0];
assign B = SW[7:4];

reg [3:0]sum;

wire Cin2;
wire Cin3;
wire Cin4;
wire gargabe;


//String of full adders wired together to add two 4 bit binary values 
FA adder1(.A(SW[4]), .B(SW[0]), .Cin(0), .Co(Cin2), .S(LEDR[0]));
FA adder2(.A(SW[5]), .B(SW[1]), .Cin(Cin2), .Co(Cin3), .S(LEDR[1]));
FA adder3(.A(SW[6]), .B(SW[2]), .Cin(Cin3), .Co(Cin4), .S(LEDR[2]));
FA adder4(.A(SW[7]), .B(SW[3]), .Cin(Cin4), .Co(garbage), .S(LEDR[3]));


//Converts to twos comp value and reassigns values to a new variable
always@(SW)
	begin
	
	if(LEDR[3] == 1)
		begin
			sum = ~LEDR[3:0]+1'b1;
		end
	
	else 
		begin
			sum = LEDR[3:0];
		end
	end
	
	

//Display value on HEX
hex7seg hexInstance1(.num(sum[3:0]), .display(HEX0));
Negative hexInstance2(.sel(LEDR[3]), .out(HEX1));

endmodule









//Full adder module 
module FA(
input A, B, Cin,
output Co, S);


   // complete SOP equation for the sum bit
   assign S = A^B^Cin ;


   //complete SOP equation for the sum bit
   assign Co = (A&B) | (A&Cin) | (B&Cin);

endmodule
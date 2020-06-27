`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:37 11/17/2019 
// Design Name: 
// Module Name:    IM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IM(
    input [31:0] IMI,
    output [31:0] IM
    );

	reg[31:0] IMR[0:1023];
	assign IM = IMR[IMI[11:2]];
	
	initial begin
		$readmemh("code.txt",IMR);
	end
	
endmodule


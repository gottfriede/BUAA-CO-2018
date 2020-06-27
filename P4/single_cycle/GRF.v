`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:56 11/09/2019 
// Design Name: 
// Module Name:    GRF 
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

module GRF(
	input [31:0] PC,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input WE,
    input reset,
    input clk,
    output [31:0] RD1,
    output [31:0] RD2
    );
	
	reg[31:0] grf[0:31];
	integer i;
	assign RD1 = grf[A1];
	assign RD2 = grf[A2];
	
	initial begin
		for (i=0;i<32;i=i+1) begin
			grf[i] = 0;
		end
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			for (i = 0;i<32;i=i+1) begin
				grf[i] <= 0;
			end
		end
		else if (WE==1&&A3!=0) begin
			grf[A3] <= WD;
			$display("@%h: $%d <= %h", PC, A3,WD);
		end
	end

endmodule

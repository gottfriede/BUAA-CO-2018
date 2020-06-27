`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:58 11/17/2019 
// Design Name: 
// Module Name:    PC 
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
module PC(
	input clk,
	input reset,
	input en,
    input [31:0] PCI,
    output reg [31:0] PC
    );
	
	initial begin
		PC = 32'h00003000;
	end
	
	always @(posedge clk) begin
		if (reset ==1) begin
			PC <= 32'h00003000;
		end
		else if (en==1) begin
			PC <= PCI;
		end
	end

endmodule


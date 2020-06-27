`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:07 11/09/2019 
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
    input [31:0] PCI,
	input clk,
	input reset,
    output [31:0] PC
    );

	reg[31:0] PCR;
	assign PC = PCR;
	
	initial begin
		PCR = 32'h00003000;
	end
	
	always @(posedge clk) begin
		if (reset ==1) begin
			PCR <= 32'h00003000;
		end
		else begin
			PCR <= PCI;
		end
	end

endmodule

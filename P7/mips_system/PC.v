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
	input IntReq,
    input [31:0] PCI,
    output reg [31:0] PC,
	output [4:0] exccode_PC
    );
	
	initial begin
		PC = 32'h00003000;
	end
	
	assign exccode_PC = ((PC[1:0]!=2'b00)||(PC<32'h00003000)||(PC>32'h00004ffc)) ? 5'b00100 : 5'b00000;
	
	always @(posedge clk) begin
		if (reset ==1) begin
			PC <= 32'h00003000;
		end
		else if (IntReq) begin
			PC <= 32'h00004180;
		end
		else if (en==1) begin
			PC <= PCI;
		end
	end

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:06 11/17/2019 
// Design Name: 
// Module Name:    FDreg 
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
module FDreg(
	input clk,
	input reset,
	input en,
	input [31:0] PC,
	input [31:0] IM,
    output reg [31:0] IR_D,
	output reg [31:0] PC_D,
	output reg [31:0] PC4_D,
	output reg [31:0] PC8_D
    );

	initial begin
		IR_D = 32'h00000000;
		PC_D = 32'h00003000;
		PC4_D = 32'h00003004;
		PC8_D = 32'h00003008;
	end
	
	always @ ( posedge clk ) begin
		if (reset == 1) begin
			IR_D <= 32'h00000000;
			PC_D <= 32'h00003000;
			PC4_D <= 32'h00003004;
			PC8_D <= 32'h00003008;
		end
		else if (en==1) begin
			IR_D <= IM;
			PC_D <= PC;
			PC4_D <= PC + 4;
			PC8_D <= PC + 8;
		end
	end

endmodule

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
	input [4:0] exccode_PC,
	input [31:0] EPC,
    output reg [31:0] IR_D,
	output reg [31:0] PC_D,
	output reg [31:0] PC4_D,
	output reg [31:0] PC8_D,
	output reg [4:0] exccode_D,
	output reg bd_D
    );

	initial begin
		IR_D = 32'h00000000;
		PC_D = 32'h00003000;
		PC4_D = 32'h00003004;
		PC8_D = 32'h00003008;
		exccode_D = 5'b00000;
		bd_D = 1'b0;
	end
	
	wire BD;
	assign BD = (IR_D[31:26]==6'b000100) ||
				(IR_D[31:26]==6'b000101) ||
				(IR_D[31:26]==6'b000110) ||
				(IR_D[31:26]==6'b000111) ||
				(IR_D[31:26]==6'b000001&&IR_D[20:16]==5'b00000) ||
				(IR_D[31:26]==6'b000001&&IR_D[20:16]==5'b00001) ||
				(IR_D[31:26]==6'b000010) ||
				(IR_D[31:26]==6'b000011) ||
				(IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b001001) ||
				(IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b001000) ;
	
	always @ ( posedge clk ) begin
		if (reset == 1) begin
			IR_D <= 32'h00000000;
			if (IR_D==32'h42000018&&en) begin
				PC_D <= EPC;
			end
			else begin
				PC_D <= 32'h00003000;
			end
			PC4_D <= 32'h00003004;
			PC8_D <= 32'h00003008;
			exccode_D <= 5'b00000;
			bd_D <= 1'b0;
		end
		else if (en==1) begin
			IR_D <= (exccode_PC==5'b00000) ? IM : 32'h00000000;
			PC_D <= PC;
			PC4_D <= PC + 4;
			PC8_D <= PC + 8;
			exccode_D <= exccode_PC;
			bd_D <= BD;
		end
	end

endmodule

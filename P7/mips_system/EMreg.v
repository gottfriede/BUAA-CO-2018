`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:47 11/17/2019 
// Design Name: 
// Module Name:    EMreg 
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
module EMreg(
    input clk,
    input reset,
	input en,
    input [31:0] IR_E,
	input [31:0] PC_E,
    input [31:0] PC4_E,
    input [31:0] PC8_E,
    input [31:0] ALU,
    input [31:0] RD2_E,
	input GRFWE_E,
	input [2:0] Tnew_E,
	input [4:0] exccode_E,
	input [4:0] exccode_ALU,
	input bd_E,
    output reg [31:0] IR_M,
	output reg [31:0] PC_M,
    output reg [31:0] PC4_M,
    output reg [31:0] PC8_M,
    output reg [31:0] ALU_M,
    output reg [31:0] RD2_M,
	output reg GRFWE_M,
	output reg [2:0] Tnew_M,
	output reg [4:0] exccode_M,
	output reg bd_M
    );

	initial begin
		IR_M = 32'h000000000;
		PC_M = 32'h00003000;
		PC4_M = 32'h00003004;
		PC8_M = 32'h00003008;
		ALU_M = 32'h00000000;
		RD2_M = 32'h00000000;
		GRFWE_M = 1'b0;
		Tnew_M = 3'b000;
		exccode_M = 5'b00000;
		bd_M = 1'b0;
	end
	
	always @ ( posedge clk ) begin
		if (reset==1) begin
			IR_M <= 32'h00000000;
			PC_M <= 32'h00003000;
			PC4_M <= 32'h00003004;
			PC8_M <= 32'h00003008;
			ALU_M <= 32'h00000000;
			RD2_M <= 32'h00000000;
			GRFWE_M <= 1'b0;
			Tnew_M <= 3'b000;
			exccode_M <= 5'b00000;
			bd_M <= 1'b0;
		end
		else if (en==1) begin
			IR_M <= IR_E;
			PC_M <= PC_E;
			PC4_M <= PC4_E;
			PC8_M <= PC8_E;
			ALU_M <= ALU;
			RD2_M <= RD2_E;
			GRFWE_M <= GRFWE_E;
			Tnew_M <= (Tnew_E==3'b000) ? 3'b000 : Tnew_E - 1;
			exccode_M <= (exccode_E==5'b00000) ? exccode_ALU : exccode_E;
			bd_M <= bd_E;
		end
	end
	
endmodule

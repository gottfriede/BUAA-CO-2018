`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:57 11/17/2019 
// Design Name: 
// Module Name:    DEreg 
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
module DEreg(
    input clk,
    input reset,
	input en,
    input [31:0] IR_D,
	input [31:0] PC_D,
    input [31:0] PC4_D,
    input [31:0] PC8_D,
    input [31:0] RD1,
    input [31:0] RD2,
    input [31:0] EXT,
	input GRFWE,
	input [2:0] Tnew,
    output reg[31:0] IR_E,
	output reg[31:0] PC_E,
    output reg[31:0] PC4_E,
    output reg[31:0] PC8_E,
    output reg[31:0] RD1_E,
    output reg[31:0] RD2_E,
    output reg[31:0] EXT_E,
	output reg GRFWE_E,
	output reg [2:0] Tnew_E
    );
	
	initial begin
		IR_E = 32'h00000000;
		PC_E = 32'h00003000;
		PC4_E = 32'h00003004;
		PC8_E = 32'h00003008;
		RD1_E = 32'h00000000;
		RD2_E = 32'h00000000;
		EXT_E = 32'h00000000;
		GRFWE_E = 1'b0;
		Tnew_E = 3'b000;
	end
	
	always @ ( posedge clk ) begin
		if (reset==1) begin
			IR_E <= 32'h00000000;
			PC_E <= 32'h00003000;
			PC4_E <= 32'h00003004;
			PC8_E <= 32'h00003008;
			RD1_E <= 32'h00000000;
			RD2_E <= 32'h00000000;
			EXT_E <= 32'h00000000;
			GRFWE_E <= 1'b0;
			Tnew_E <= 3'b000;
		end
		else if (en==1) begin
			IR_E <= IR_D;
			PC_E <= PC_D;
			PC4_E <= PC4_D;
			PC8_E <= PC8_D;
			RD1_E <= RD1;
			RD2_E <= RD2;
			EXT_E <= EXT;
			GRFWE_E <= GRFWE;
			Tnew_E <= (Tnew==3'b000) ? 3'b000 : Tnew - 1;
		end
	end

endmodule
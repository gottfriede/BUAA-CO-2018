`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:18 11/17/2019 
// Design Name: 
// Module Name:    MWreg 
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
module MWreg(
    input clk,
    input reset,
	input en,
    input [31:0] IR_M,
	input [31:0] PC_M,
    input [31:0] PC4_M,
    input [31:0] PC8_M,
    input [31:0] ALU_M,
    input [31:0] DM,
    output reg[31:0] IR_W,
	output reg[31:0] PC_W,
    output reg[31:0] PC4_W,
    output reg[31:0] PC8_W,
    output reg[31:0] ALU_W,
    output reg[31:0] DM_W
    );
	
	initial begin
		IR_W = 32'h00000000;
		PC_W = 32'h00003000;
		PC4_W = 32'h00003004;
		PC8_W = 32'h00003008;
		ALU_W = 32'h00000000;
		DM_W = 32'h00000000;
	end
	
	always @ ( posedge clk ) begin
		if (reset==1) begin
			IR_W <= 32'h00000000;
			PC_W <= 32'h00003000;
			PC4_W <= 32'h00003004;
			PC8_W <= 32'h00003008;
			ALU_W <= 32'h00000000;
			DM_W <= 32'h00000000;
		end
		else if (en==1) begin
			IR_W <= IR_M;
			PC_W <= PC_M;
			PC4_W <= PC4_M;
			PC8_W <= PC8_M;
			ALU_W <= ALU_M;
			DM_W <= DM;
		end
	end

endmodule


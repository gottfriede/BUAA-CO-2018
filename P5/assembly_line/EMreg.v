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
    output reg [31:0] IR_M,
	output reg [31:0] PC_M,
    output reg [31:0] PC4_M,
    output reg [31:0] PC8_M,
    output reg [31:0] ALU_M,
    output reg [31:0] RD2_M
    );

	initial begin
		IR_M = 32'h000000000;
		PC_M = 32'h00003000;
		PC4_M = 32'h00003004;
		PC8_M = 32'h00003008;
		ALU_M = 32'h00000000;
		RD2_M = 32'h00000000;
	end
	
	always @ ( posedge clk ) begin
		if (reset==1) begin
			IR_M <= 32'h00000000;
			PC_M <= 32'h00003000;
			PC4_M <= 32'h00003004;
			PC8_M <= 32'h00003008;
			ALU_M <= 32'h00000000;
			RD2_M <= 32'h00000000;
		end
		else if (en==1) begin
			IR_M <= IR_E;
			PC_M <= PC_E;
			PC4_M <= PC4_E;
			PC8_M <= PC8_E;
			ALU_M <= ALU;
			RD2_M <= RD2_E;
		end
	end
	
endmodule

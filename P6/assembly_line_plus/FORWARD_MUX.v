`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:55 11/17/2019 
// Design Name: 
// Module Name:    FORWARD_MUX 
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
module FORWARD_MUX(
    input [31:0] RD1,
    input [31:0] RD2,
    input [31:0] RD1_E,
    input [31:0] RD2_E,
    input [31:0] RD2_M,
    input [31:0] PC8_E,
    input [31:0] ALU_M,
    input [31:0] PC8_M,
    input [31:0] WD,
    input [31:0] PC8_W,
    input [2:0] M_RD1_D_Op,
    input [2:0] M_RD2_D_Op,
    input [2:0] M_RD1_E_Op,
    input [2:0] M_RD2_E_Op,
    input [2:0] M_RD2_M_Op,
    output reg [31:0] M_RD1_D,
    output reg [31:0] M_RD2_D,
    output reg [31:0] M_RD1_E,
    output reg [31:0] M_RD2_E,
    output reg [31:0] M_RD2_M
    );

	always @ ( * ) begin
		case (M_RD1_D_Op)
			3'b000: M_RD1_D <= RD1;
			3'b001: M_RD1_D <= ALU_M;
			3'b010: M_RD1_D <= WD;
			3'b011: M_RD1_D <= PC8_E;
			3'b100: M_RD1_D <= PC8_M;
			3'b101: M_RD1_D <= PC8_W;
			default: M_RD1_D <= 32'h00000000;
		endcase
		
		case (M_RD2_D_Op)
			3'b000: M_RD2_D <= RD2;
			3'b001: M_RD2_D <= ALU_M;
			3'b010: M_RD2_D <= WD;
			3'b011: M_RD2_D <= PC8_E;
			3'b100: M_RD2_D <= PC8_M;
			3'b101: M_RD2_D <= PC8_W;
			default: M_RD2_D <= 32'h00000000;
		endcase
		
		case (M_RD1_E_Op)
			3'b000: M_RD1_E <= RD1_E;
			3'b001: M_RD1_E <= ALU_M;
			3'b010: M_RD1_E <= WD;
			3'b011: M_RD1_E <= 32'h00000000;
			3'b100: M_RD1_E <= PC8_M;
			3'b101: M_RD1_E <= PC8_W;
			default: M_RD1_E <= 32'h00000000;
		endcase
		
		case (M_RD2_E_Op)
			3'b000: M_RD2_E <= RD2_E;
			3'b001: M_RD2_E <= ALU_M;
			3'b010: M_RD2_E <= WD;
			3'b011: M_RD2_E <= 32'h00000000;
			3'b100: M_RD2_E <= PC8_M;
			3'b101: M_RD2_E <= PC8_W;
			default: M_RD2_E <= 32'h00000000;
		endcase
		
		case (M_RD2_M_Op)
			3'b000: M_RD2_M <= RD2_M;
			3'b001: M_RD2_M <= 32'h00000000;
			3'b010: M_RD2_M <= WD;
			3'b011: M_RD2_M <= 32'b00000000;
			3'b100: M_RD2_M <= 32'h00000000;
			3'b101: M_RD2_M <= PC8_W;
			default: M_RD2_M <= 32'h00000000;
		endcase
	end

endmodule

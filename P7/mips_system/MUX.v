`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:56 11/18/2019 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
	input [31:0] M_RD1_E,
    input [31:0] M_RD2_E,
	input [31:0] IR_E,
    input [31:0] EXT_E,
    input [31:0] IR_W,
    input [31:0] ALU_W,
    input [31:0] DM_W,
    input [31:0] PC8_W,
	input [31:0] HI,
	input [31:0] LO,
	input [31:0] TDM,
	input [31:0] Dout,
	input ALUA_MUXOp,
    input ALUB_MUXOp,
    input [1:0] GRFA3_MUXOp,
    input [2:0] GRFWD_MUXOp,
	input TTDM_MUXOp,
	output reg [31:0] ALUA,
    output reg [31:0] ALUB,
    output reg [4:0] GRFA3,
    output reg [31:0] GRFWD,
	output reg [31:0] TTDM
    );

	always @ ( * ) begin
		case (ALUA_MUXOp)
			1'b0: ALUA <= M_RD1_E;
			1'b1: ALUA <= {{27{1'b0}},IR_E[10:6]};
			default: ALUA <= 32'h00000000;
		endcase
	
		case (ALUB_MUXOp)
			1'b0: ALUB <= M_RD2_E;
			1'b1: ALUB <= EXT_E;
			default: ALUB <= 32'h00000000;
		endcase
		
		case (GRFA3_MUXOp)
			2'b00: GRFA3 <= IR_W[20:16];
			2'b01: GRFA3 <= IR_W[15:11];
			2'b10: GRFA3 <= 5'h1f;
			default: GRFA3 <= 5'b00000;
		endcase
		
		case (GRFWD_MUXOp)
			3'b000: GRFWD <= ALU_W;
			3'b001: GRFWD <= DM_W;
			3'b010: GRFWD <= PC8_W;
			3'b011: GRFWD <= HI;
			3'b100: GRFWD <= LO;
			default: GRFWD <= 32'h00000000;
		endcase
		
		case (TTDM_MUXOp)
			1'b0 : TTDM <= TDM;
			1'b1 : TTDM <= Dout;
		endcase
	end

endmodule

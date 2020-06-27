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
    input [31:0] M_RD2_E,
    input [31:0] EXT_E,
    input [31:0] IR_W,
    input [31:0] ALU_W,
    input [31:0] DM_W,
    input [31:0] PC8_W,
    input ALUB_MUXOp,
    input [1:0] GRFA3_MUXOp,
    input [1:0] GRFWD_MUXOp,
    output reg [31:0] ALUB,
    output reg [4:0] GRFA3,
    output reg [31:0] GRFWD
    );

	always @ ( * ) begin
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
			2'b00: GRFWD <= ALU_W;
			2'b01: GRFWD <= DM_W;
			2'b10: GRFWD <= PC8_W;
			default: GRFWD <= 32'h00000000;
		endcase
	end

endmodule

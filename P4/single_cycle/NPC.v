`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:51 11/09/2019 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] NPCI,
    input [31:0] NPCIMM,
    input [1:0] NPCOp,
    output [31:0] NPC
    );

	parameter add_4_Op = 2'b00,
					add_4_IMM_Op = 2'b01,
					move_IMM_Op = 2'b10;
	
	reg[31:0] NPCOUT;
	assign NPC = NPCOUT;
	
	always @( * ) begin
		case(NPCOp)
		add_4_Op:
			NPCOUT <= NPCI + 4;
		add_4_IMM_Op:
			NPCOUT <= NPCI + 4 + NPCIMM;
		move_IMM_Op:
			NPCOUT <= NPCIMM;
		default:
			NPCOUT <= NPCI;
		endcase
	end


endmodule

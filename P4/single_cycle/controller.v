`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:42 11/09/2019 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [5:0] opcode,
    input [5:0] func,
    output [1:0] NPCOp,
    output GRFWE,
    output [2:0] ALUOp,
    output [2:0] EXTOp,
    output DMWE,
    output [1:0] GRFA3_MUXOp,
    output [1:0] GRFWD_MUXOp,
    output ALUB_MUXOp,
    output [1:0] NPCIMM_MUXOp
    );

	wire addu,subu,ori,lw,sw,beq,lui,jal,jr,nop;
	assign addu = (opcode==6'b000000&&func==6'b100001) ? 1: 0;
	assign subu = (opcode==6'b000000&&func==6'b100011) ? 1 : 0;
	assign ori = (opcode==6'b001101) ? 1 : 0;
	assign lw = (opcode==6'b100011) ? 1 : 0;
	assign sw = (opcode==6'b101011) ? 1 : 0;
	assign beq = (opcode==6'b000100) ? 1 : 0;
	assign lui = (opcode==6'b001111) ? 1 : 0;
	assign jal = (opcode==6'b000011) ? 1 : 0;
	assign jr = (opcode==6'b000000&&func==6'b001000) ? 1 : 0;
	
	assign NPCOp[0] = beq;
	assign NPCOp[1] = jal||jr;
	assign GRFWE = addu||subu||ori||lw||lui||jal;
	assign ALUOp[0] = addu||ori||lw||sw;
	assign ALUOp[1] = subu||ori||beq;
	assign ALUOp[2] = 0;
	assign EXTOp[0] = ori||beq;
	assign EXTOp[1] = lw||sw||beq;
	assign EXTOp[2] = lui;
	assign DMWE = sw;
	assign GRFA3_MUXOp[0] = addu||subu;
	assign GRFA3_MUXOp[1] = jal;
	assign GRFWD_MUXOp[0] = lw||jal;
	assign GRFWD_MUXOp[1] = lui||jal;
	assign ALUB_MUXOp = addu||subu||beq;
	assign NPCIMM_MUXOp[0] = jal;
	assign NPCIMM_MUXOp[1] = jr;
 	
endmodule

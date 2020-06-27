`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:39 11/08/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

	wire[31:0] IM;
	wire[5:0] opcode;
	wire[4:0] rs;
	wire[4:0] rt;
	wire[4:0] rd;
	wire[4:0] shamt;
	wire[5:0] func;
	wire[15:0] imm;
	wire[25:0] index;
	wire[31:0] ALUA;
	wire[31:0] ALUB;
	wire[2:0] ALUOp;
	wire[31:0] ALU;
	wire[31:0] DMA;
	wire[31:0] DMD;
	wire DMWE;
	wire[31:0] DM;
	wire[15:0] EXTIMM;
	wire[2:0] EXTOp;
	wire[31:0] EXT;
	wire[4:0] A1;
	wire[4:0] A2;
	wire[4:0] A3;
	wire[31:0] WD;
	wire WE;
	wire[31:0] RD1;
	wire[31:0] RD2;
	wire[31:0] IMI;
	wire[31:0] NPCI;
	wire[31:0] NPCIMM;
	wire[1:0] NPCOp;
	wire[1:0] TNPCOp;
	wire[31:0] NPC;
	wire[31:0] PCI;
	wire[31:0] PC;
	
	wire[1:0] NPCIMM_MUXOp;
	wire[1:0] GRFA3_MUXOp;
	wire[1:0] GRFWD_MUXOp;
	wire ALUB_MUXOp;
	
	assign opcode = IM[31:26];
	assign rs = IM[25:21];
	assign rt = IM[20:16];
	assign rd = IM[15:11];
	assign shamt = IM[10:6];
	assign func = IM[5:0];
	assign imm = IM[15:0];
	assign index = IM[25:0];
	
	assign ALUA = RD1;
	assign DMA = ALU;
	assign DMD = RD2;
	assign EXTIMM = imm;
	assign A1 = rs;
	assign A2 = rt;
	assign IMI = PC;
	assign NPCI = PC;
	assign TNPCOp[1] = NPCOp[1];
	assign TNPCOp[0] = NPCOp[0] && (ALU == 0);
	assign PCI = NPC;
	
	ALU my_ALU(ALUA,ALUB,ALUOp,ALU);
	DM my_DM(PC,DMA,DMD,DMWE,clk,reset,DM);
	EXT my_EXT(EXTIMM,EXTOp,EXT);
	GRF my_GRF(PC,A1,A2,A3,WD,WE,reset,clk,RD1,RD2);
	IM my_IM(IMI,IM);
	NPC my_NPC(NPCI,NPCIMM,TNPCOp,NPC);
	PC my_PC(PCI,clk,reset,PC);
	controller my_controller(opcode,func,NPCOp,WE,ALUOp,EXTOp,DMWE,GRFA3_MUXOp,GRFWD_MUXOp,ALUB_MUXOp,NPCIMM_MUXOp);
	MUX my_MUX(EXT,PC,index,RD1,rt,rd,ALU,DM,RD2,NPCIMM_MUXOp,GRFA3_MUXOp,GRFWD_MUXOp,ALUB_MUXOp,NPCIMM,A3,WD,ALUB);

endmodule

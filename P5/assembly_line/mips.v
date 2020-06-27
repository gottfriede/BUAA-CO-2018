`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:04 11/17/2019 
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
	
	wire PCen;
	wire [1:0] PCOp;
	wire [31:0] PC;
	wire [31:0] PC4;
	wire [31:0] IM;
	
	wire FDen;
	wire DEen;
	wire EMen;
	wire MWen;
	wire FDreset;
	wire DEreset;
	wire EMreset;
	wire MWreset;
	wire [31:0] IR_D;
	wire [31:0] PC_D;
	wire [31:0] PC4_D;
	wire [31:0] PC8_D;
	wire [31:0] IR_E;
	wire [31:0] PC_E;
	wire [31:0] PC4_E;
	wire [31:0] PC8_E;
	wire [31:0] RD1_E;
	wire [31:0] RD2_E;
	wire [31:0] EXT_E;
	wire [31:0] IR_M;
	wire [31:0] PC_M;
	wire [31:0] PC4_M;
	wire [31:0] PC8_M;
	wire [31:0] ALU_M;
	wire [31:0] RD2_M;
	wire [31:0] IR_W;
	wire [31:0] PC_W;
	wire [31:0] PC4_W;
	wire [31:0] PC8_W;
	wire [31:0] DM_W;
	wire [31:0] ALU_W;
	
	wire ZERO;
	wire is_B;
	wire is_J;
	wire [1:0] EXTOp;
	wire [2:0] ALUOp;
	wire [1:0] GRFA3_MUXOp;
	wire ALUB_MUXOp;
	wire GRFWE;
	wire DMWE;
	wire [1:0] GRFWD_MUXOp;
	wire [4:0] GRFA3;
	wire [31:0] GRFWD;
	wire [31:0] GRFRD1;
	wire [31:0] GRFRD2;
	wire [31:0] EXT;
	wire [31:0] ALUB;
	wire [31:0] ALU;
	wire [31:0] DM;
	wire [31:0] TURE_NPC;
	
	wire [2:0] M_RD1_D_Op;
	wire [2:0] M_RD2_D_Op;
	wire [2:0] M_RD1_E_Op;
	wire [2:0] M_RD2_E_Op;
	wire [2:0] M_RD2_M_Op;
	wire [31:0] M_RD1_D;
	wire [31:0] M_RD2_D;
	wire [31:0] M_RD1_E;
	wire [31:0] M_RD2_E;
	wire [31:0] M_RD2_M;
	
	assign DEen = 1;
	assign EMen = 1;
	assign MWen = 1;
	assign FDreset = 0;
	assign EMreset = 0;
	assign MWreset = 0;
	assign PC4 = PC + 4;
///////////// the begining of F
	PC my_PC(
		.clk(clk),
		.reset(reset),
		.en(PCen),
		.PCI(TURE_NPC),
		.PC(PC)
		);
	IM my_IM(
		.IMI(PC),
		.IM(IM)
		);
///////////// the end of F
///////////// the begining of F/D REG
	FDreg my_FDreg(
		.clk(clk),
		.reset(reset||FDreset),
		.en(FDen),
		.PC(PC),
		.IM(IM),
		.IR_D(IR_D),
		.PC_D(PC_D),
		.PC4_D(PC4_D),
		.PC8_D(PC8_D)
		);
///////////// the end of F/D REG
///////////// the begining of D
	controller my_D_controller(
		.opcode(IR_D[31:26]),
		.func(IR_D[5:0]),
		.EXTOp(EXTOp),
		.is_B(is_B),
		.is_J(is_J),
		.PCOp(PCOp)
		);
	GRF my_GRF(
		.clk(clk),
		.reset(reset),
		.PC(PC_W),
		.A1(IR_D[25:21]),
		.A2(IR_D[20:16]),
		.A3(GRFA3),
		.WD(GRFWD),
		.WE(GRFWE),
		.RD1(GRFRD1),
		.RD2(GRFRD2)
	);
	CMP my_CMP(
		.D1(M_RD1_D),
		.D2(M_RD2_D),
		.CMP(ZERO)
	);
	EXT my_EXT(
		.IMM(IR_D[15:0]),
		.EXTOp(EXTOp),
		.EXTOUT(EXT)
	);
	NPC my_NPC(
		.ADD4(PC4),
		.PC4_D(PC4_D),
		.imm_index(IR_D[25:0]),
		.M_RD1_D(M_RD1_D),
		.ZERO(ZERO),
		.is_B(is_B),
		.is_J(is_J),
		.PCOp(PCOp),
		.TURE_NPC(TURE_NPC)
	);
///////////// the end of D
///////////// the begining of D/E REG
	DEreg my_DEreg(
		.clk(clk),
		.reset(reset||DEreset),
		.en(DEen),
		.IR_D(IR_D),
		.PC_D(PC_D),
		.PC4_D(PC4_D),
		.PC8_D(PC8_D),
		.RD1(M_RD1_D),
		.RD2(M_RD2_D),
		.EXT(EXT),
		.IR_E(IR_E),
		.PC_E(PC_E),
		.PC4_E(PC4_E),
		.PC8_E(PC8_E),
		.RD1_E(RD1_E),
		.RD2_E(RD2_E),
		.EXT_E(EXT_E)
	);
///////////// the end of D/E REG
///////////// the begining of E
	controller my_E_controller(
		.opcode(IR_E[31:26]),
		.func(IR_E[5:0]),
		.ALUOp(ALUOp),
		.ALUB_MUXOp(ALUB_MUXOp)
	);
	ALU my_ALU(
		.A(M_RD1_E),
		.B(ALUB),
		.ALUOp(ALUOp),
		.ALUOUT(ALU)
	);
///////////// the end of E
///////////// the begining of E/M REG
	EMreg my_EMreg(
		.clk(clk),
		.reset(reset||EMreset),
		.en(EMen),
		.IR_E(IR_E),
		.PC_E(PC_E),
		.PC4_E(PC4_E),
		.PC8_E(PC8_E),
		.ALU(ALU),
		.RD2_E(M_RD2_E),
		.IR_M(IR_M),
		.PC_M(PC_M),
		.PC4_M(PC4_M),
		.PC8_M(PC8_M),
		.ALU_M(ALU_M),
		.RD2_M(RD2_M)
	);
///////////// the end of E/M REG
///////////// the begining of M
	controller my_M_controller(
		.opcode(IR_M[31:26]),
		.func(IR_M[5:0]),
		.DMWE(DMWE)
	);
	DM my_DM(
		.clk(clk),
		.reset(reset),
		.PC(PC_M),
		.DMA(ALU_M),
		.DMD(M_RD2_M),
		.DMWE(DMWE),
		.DM(DM)
	);
///////////// the end of M
///////////// the begining of M/W REG
	MWreg my_MWreg(
		.clk(clk),
		.reset(reset||MWreset),
		.en(MWen),
		.IR_M(IR_M),
		.PC_M(PC_M),
		.PC4_M(PC4_M),
		.PC8_M(PC8_M),
		.ALU_M(ALU_M),
		.DM(DM),
		.IR_W(IR_W),
		.PC_W(PC_W),
		.PC4_W(PC4_W),
		.PC8_W(PC8_W),
		.ALU_W(ALU_W),
		.DM_W(DM_W)
	);
///////////// the end of M/W REG
///////////// the begining of W
	controller my_W_controller(
		.opcode(IR_W[31:26]),
		.func(IR_W[5:0]),
		.GRFWE(GRFWE),
		.GRFA3_MUXOp(GRFA3_MUXOp),
		.GRFWD_MUXOp(GRFWD_MUXOp)
	);
///////////// the end of W
///////////// the begining of MUX/FORWARDING/ADVENTURE
	MUX my_MUX(
		.M_RD2_E(M_RD2_E),
		.EXT_E(EXT_E),
		.IR_W(IR_W),
		.ALU_W(ALU_W),
		.DM_W(DM_W),
		.PC8_W(PC8_W),
		.ALUB_MUXOp(ALUB_MUXOp),
		.GRFA3_MUXOp(GRFA3_MUXOp),
		.GRFWD_MUXOp(GRFWD_MUXOp),
		.ALUB(ALUB),
		.GRFA3(GRFA3),
		.GRFWD(GRFWD)
	);
	FORWARD_MUX my_FORWARD_MUX(
		.RD1(GRFRD1),
		.RD2(GRFRD2),
		.RD1_E(RD1_E),
		.RD2_E(RD2_E),
		.RD2_M(RD2_M),
		.PC8_E(PC8_E),
		.ALU_M(ALU_M),
		.PC8_M(PC8_M),
		.WD(GRFWD),
		.PC8_W(PC8_W),
		.M_RD1_D_Op(M_RD1_D_Op),
		.M_RD2_D_Op(M_RD2_D_Op),
		.M_RD1_E_Op(M_RD1_E_Op),
		.M_RD2_E_Op(M_RD2_E_Op),
		.M_RD2_M_Op(M_RD2_M_Op),
		.M_RD1_D(M_RD1_D),
		.M_RD2_D(M_RD2_D),
		.M_RD1_E(M_RD1_E),
		.M_RD2_E(M_RD2_E),
		.M_RD2_M(M_RD2_M)
	);
	Adventure my_Adventure(
		.IR_D(IR_D),
		.IR_E(IR_E),
		.IR_M(IR_M),
		.IR_W(IR_W),
		.D_en(FDen),
		.E_clr(DEreset),
		.PC_en(PCen),
		.M_RD1_D_Op(M_RD1_D_Op),
		.M_RD2_D_Op(M_RD2_D_Op),
		.M_RD1_E_Op(M_RD1_E_Op),
		.M_RD2_E_Op(M_RD2_E_Op),
		.M_RD2_M_Op(M_RD2_M_Op)
	);
///////////// the end of MUX/FORWARDING/ADVENTURE

endmodule

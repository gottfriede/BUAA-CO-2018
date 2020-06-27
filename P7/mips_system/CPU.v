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
module CPU(
    input clk,
    input reset,
	input [31:0] PrRD,
	input [7:2] HWInt,
	output [31:0] PrAddr,
	output [31:0] PrWD,
	output PrWE,
	output [3:0] PrBE,
	output [31:0] addr
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
	wire GRFWE_E;
	wire [31:0] IR_M;
	wire [31:0] PC_M;
	wire [31:0] PC4_M;
	wire [31:0] PC8_M;
	wire [31:0] ALU_M;
	wire [31:0] RD2_M;
	wire GRFWE_M;
	wire [31:0] IR_W;
	wire [31:0] PC_W;
	wire [31:0] PC4_W;
	wire [31:0] PC8_W;
	wire [31:0] DM_W;
	wire [31:0] ALU_W;
	wire GRFWE_W;
	
	wire CMP;
	wire [2:0] CMPOp;
	wire is_B;
	wire is_J;
	wire [1:0] EXTOp;
	wire [3:0] ALUOp;
	wire [1:0] GRFA3_MUXOp;
	wire ALUA_MUXOp;
	wire ALUB_MUXOp;
	wire GRFWE;
	wire DMWE;
	wire [1:0] DMOp;
	wire [2:0] DMEXTOp;
	wire [2:0] GRFWD_MUXOp;
	wire [4:0] GRFA3;
	wire [31:0] GRFWD;
	wire [31:0] GRFRD1;
	wire [31:0] GRFRD2;
	wire [31:0] EXT;
	wire [31:0] ALUA;
	wire [31:0] ALUB;
	wire [31:0] ALU;
	wire [31:0] DM;
	wire [31:0] DMEXT;
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
	
	wire [1:0] E_A3_Op;
	wire [1:0] M_A3_Op;
	wire [1:0] W_A3_Op;
	wire [2:0] E_WD_Op;
	wire [2:0] M_WD_Op;
	wire [2:0] W_WD_Op;
	wire [4:0] E_A3;
	wire [4:0] M_A3;
	wire [4:0] W_A3;
	wire [31:0] E_WD;
	wire [31:0] M_WD;
	wire [31:0] W_WD;
	
	wire [2:0] Tuse_rs;
	wire [2:0] Tuse_rt;
	wire [2:0] Tnew;
	wire [2:0] Tnew_E;
	wire [2:0] Tnew_M;
	
	wire [2:0] XALUOp;
	wire START;
	wire BUSY;
	wire [31:0] HI;
	wire [31:0] LO;
	
	wire [4:0] exccode_PC;
	wire [4:0] exccode_controller;
	wire [4:0] exccode_ALU;
	wire [4:0] exccode_DM;
	wire [4:0] exccode_D;
	wire [4:0] exccode_E;
	wire [4:0] exccode_M;
	
	wire CP0WE;
	wire TTDM_MUXOp;
	wire TDMWE;
	wire [4:0] ExcCode;
	wire EXLSet;
	wire EXLClr;
	wire IntReq;
	wire [31:2] EPC;
	wire [31:0] Dout;
	wire [31:0] TDM;
	wire [31:0] TTDM;
	
	wire bd_D;
	wire bd_E;
	wire bd_M;
	
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
		.IntReq(IntReq),
		.PCI(TURE_NPC),
		.PC(PC),
		.exccode_PC(exccode_PC)
	);
	IM my_IM(
		.IMI(PC),
		.IM(IM)
	);
///////////// the end of F
///////////// the begining of F/D REG
	FDreg my_FDreg(
		.clk(clk),
		.reset(reset||FDreset||IntReq||(IR_D==32'h42000018&&FDen)),
		.en(FDen),
		.PC(PC),
		.IM(IM),
		.exccode_PC(exccode_PC),
		.EPC({EPC,2'b00}),
		.IR_D(IR_D),
		.PC_D(PC_D),
		.PC4_D(PC4_D),
		.PC8_D(PC8_D),
		.exccode_D(exccode_D),
		.bd_D(bd_D)
	);
///////////// the end of F/D REG
///////////// the begining of D
	controller my_D_controller(
		.opcode(IR_D[31:26]),
		.func(IR_D[5:0]),
		.rs(IR_D[25:21]),
		.rt(IR_D[20:16]),
		.GRFWE(GRFWE),
		.EXTOp(EXTOp),
		.is_B(is_B),
		.is_J(is_J),
		.PCOp(PCOp),
		.Tuse_rs(Tuse_rs),
		.Tuse_rt(Tuse_rt),
		.Tnew(Tnew),
		.CMPOp(CMPOp),
		.exccode_controller(exccode_controller)
	);
	GRF my_GRF(
		.clk(clk),
		.reset(reset),
		.PC(PC_W),
		.A1(IR_D[25:21]),
		.A2(IR_D[20:16]),
		.A3(GRFA3),
		.WD(GRFWD),
		.WE(GRFWE_W),
		.RD1(GRFRD1),
		.RD2(GRFRD2)
	);
	CMP my_CMP(
		.D1(M_RD1_D),
		.D2(M_RD2_D),
		.CMPOp(CMPOp),
		.CMP(CMP)
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
		.CMP(CMP),
		.is_B(is_B),
		.is_J(is_J),
		.PCOp(PCOp),
		.IntReq(IntReq),
		.EPC({EPC,2'b00}),
		.TURE_NPC(TURE_NPC)
	);
///////////// the end of D
///////////// the begining of D/E REG
	DEreg my_DEreg(
		.clk(clk),
		.reset(reset||DEreset||IntReq),
		.en(DEen),
		.IR_D(IR_D),
		.PC_D(PC_D),
		.PC4_D(PC4_D),
		.PC8_D(PC8_D),
		.RD1(M_RD1_D),
		.RD2(M_RD2_D),
		.EXT(EXT),
		.GRFWE(GRFWE),
		.Tnew(Tnew),
		.exccode_D(exccode_D),
		.exccode_controller(exccode_controller),
		.bd_D(bd_D),
		.IR_E(IR_E),
		.PC_E(PC_E),
		.PC4_E(PC4_E),
		.PC8_E(PC8_E),
		.RD1_E(RD1_E),
		.RD2_E(RD2_E),
		.EXT_E(EXT_E),
		.GRFWE_E(GRFWE_E),
		.Tnew_E(Tnew_E),
		.exccode_E(exccode_E),
		.bd_E(bd_E)
	);
///////////// the end of D/E REG
///////////// the begining of E
	controller my_E_controller(
		.opcode(IR_E[31:26]),
		.func(IR_E[5:0]),
		.rs(IR_E[25:21]),
		.rt(IR_E[20:16]),
		.ALUOp(ALUOp),
		.ALUB_MUXOp(ALUB_MUXOp),
		.A3_Op(E_A3_Op),
		.WD_Op(E_WD_Op),
		.ALUA_MUXOp(ALUA_MUXOp),
		.XALUOp(XALUOp),
		.START(START)
	);
	ALU my_ALU(
		.A(ALUA),
		.B(ALUB),
		.ALUOp(ALUOp),
		.IR_E(IR_E),
		.ALUOUT(ALU),
		.exccode_ALU(exccode_ALU)
	);
	XALU my_XALU(
		.clk(clk),
		.reset(reset),
		.XALUA(ALUA),
		.XALUB(ALUB),
		.XALUOp(XALUOp),
		.START(START&&!IntReq),
		.IntReq(IntReq),
		.BUSY(BUSY),
		.HIGH(HI),
		.LOW(LO)
	);
///////////// the end of E
///////////// the begining of E/M REG
	EMreg my_EMreg(
		.clk(clk),
		.reset(reset||EMreset||IntReq),
		.en(EMen),
		.IR_E(IR_E),
		.PC_E(PC_E),
		.PC4_E(PC4_E),
		.PC8_E(PC8_E),
		.ALU(ALU),
		.RD2_E(M_RD2_E),
		.GRFWE_E(GRFWE_E),
		.Tnew_E(Tnew_E),
		.exccode_E(exccode_E),
		.exccode_ALU(exccode_ALU),
		.bd_E(bd_E),
		.IR_M(IR_M),
		.PC_M(PC_M),
		.PC4_M(PC4_M),
		.PC8_M(PC8_M),
		.ALU_M(ALU_M),
		.RD2_M(RD2_M),
		.GRFWE_M(GRFWE_M),
		.Tnew_M(Tnew_M),
		.exccode_M(exccode_M),
		.bd_M(bd_M)
	);
///////////// the end of E/M REG
///////////// the begining of M
	controller my_M_controller(
		.opcode(IR_M[31:26]),
		.func(IR_M[5:0]),
		.rs(IR_M[25:21]),
		.rt(IR_M[20:16]),
		.DMWE(DMWE),
		.A3_Op(M_A3_Op),
		.WD_Op(M_WD_Op),
		.DMOp(DMOp),
		.DMEXTOp(DMEXTOp),
		.CP0WE(CP0WE),
		.TTDM_MUXOp(TTDM_MUXOp)
	);
	
	assign TDMWE = (ALU_M>=32'h00000000&&ALU_M<=32'h00002fff) ? (DMWE&&!IntReq) : 1'b0;
	assign PrWE = DMWE&&!IntReq&&( (ALU_M>=32'h00007f00&&ALU_M<=32'h00007f0b) ||
								    (ALU_M>=32'h00007f10&&ALU_M<=32'h00007f1b) );
	
	DM my_DM(
		.clk(clk),
		.reset(reset),
		.PC(PC_M),
		.DMA(ALU_M),
		.DMD(M_RD2_M),
		.DMWE(TDMWE),
		.DMOp(DMOp),
		.IR_M(IR_M),
		.DM(DM),
		.exccode_DM(exccode_DM)
	);
	
	assign PrAddr = ALU_M;
	assign PrWD = M_RD2_M;
	assign PrBE = 4'b0000;
	assign addr = PC_M;
	
	DMEXT my_DMEXT(
		.DM(DM),
		.DMA(ALU_M),
		.DMEXTOp(DMEXTOp),
		.DMEXT(DMEXT)
	);
	
	
	assign ExcCode = (exccode_M==5'b00000) ? exccode_DM : exccode_M; 
	assign EXLSet = IntReq;
	assign EXLClr = (IR_M==32'h42000018);
	
	CP0 my_CP0(
		.A1(IR_M[15:11]),
		.A2(IR_M[15:11]),
		.Din(M_RD2_M),
		.PC(PC_M[31:2]),
		.ExcCode(ExcCode),
		.HWInt(HWInt),
		.WE(CP0WE),
		.EXLSet(EXLSet),
		.EXLClr(EXLClr),
		.clk(clk),
		.reset(reset),
		.bd_M(bd_M),
		.IntReq(IntReq),
		.EPC(EPC),
		.Dout(Dout)
	);
	
	assign TDM = (ALU_M>=32'h00000000&&ALU_M<=32'h00002ffc) ? DMEXT : PrRD;
///////////// the end of M
///////////// the begining of M/W REG
	MWreg my_MWreg(
		.clk(clk),
		.reset(reset||MWreset||IntReq),
		.en(MWen),
		.IR_M(IR_M),
		.PC_M(PC_M),
		.PC4_M(PC4_M),
		.PC8_M(PC8_M),
		.ALU_M(ALU_M),
		.DM(TTDM),
		.GRFWE_M(GRFWE_M),
		.IR_W(IR_W),
		.PC_W(PC_W),
		.PC4_W(PC4_W),
		.PC8_W(PC8_W),
		.ALU_W(ALU_W),
		.DM_W(DM_W),
		.GRFWE_W(GRFWE_W)
	);
///////////// the end of M/W REG
///////////// the begining of W
	controller my_W_controller(
		.opcode(IR_W[31:26]),
		.func(IR_W[5:0]),
		.rs(IR_W[25:21]),
		.rt(IR_W[20:16]),
		.GRFA3_MUXOp(GRFA3_MUXOp),
		.GRFWD_MUXOp(GRFWD_MUXOp),
		.A3_Op(W_A3_Op),
		.WD_Op(W_WD_Op)
	);
///////////// the end of W
///////////// the begining of MUX/FORWARDING/ADVENTURE/ANALYSIS
	MUX my_MUX(
		.M_RD1_E(M_RD1_E),
		.M_RD2_E(M_RD2_E),
		.IR_E(IR_E),
		.EXT_E(EXT_E),
		.IR_W(IR_W),
		.ALU_W(ALU_W),
		.DM_W(DM_W),
		.PC8_W(PC8_W),
		.HI(HI),
		.LO(LO),
		.TDM(TDM),
		.Dout(Dout),
		.ALUA_MUXOp(ALUA_MUXOp),
		.ALUB_MUXOp(ALUB_MUXOp),
		.GRFA3_MUXOp(GRFA3_MUXOp),
		.GRFWD_MUXOp(GRFWD_MUXOp),
		.TTDM_MUXOp(TTDM_MUXOp),
		.ALUA(ALUA),
		.ALUB(ALUB),
		.GRFA3(GRFA3),
		.GRFWD(GRFWD),
		.TTDM(TTDM)
	);
	StopUnit my_StopUnit(
		.Tuse_rs(Tuse_rs),
		.Tuse_rt(Tuse_rt),
		.Tnew_E(Tnew_E),
		.Tnew_M(Tnew_M),
		.E_A3(E_A3),
		.M_A3(M_A3),
		.IR_D(IR_D),
		.IR_E(IR_E),
		.IR_M(IR_M),
		.BUSY(BUSY),
		.D_en(FDen),
		.E_clr(DEreset),
		.PC_en(PCen)
	);
	ForwardUnit my_ForwardUnit(
		.E_WD(E_WD),
		.M_WD(M_WD),
		.W_WD(W_WD),
		.E_A3(E_A3),
		.M_A3(M_A3),
		.W_A3(W_A3),
		.GRFWE_E(GRFWE_E),
		.GRFWE_M(GRFWE_M),
		.GRFWE_W(GRFWE_W),
		.RD1(GRFRD1),
		.RD2(GRFRD2),
		.RD1_E(RD1_E),
		.RD2_E(RD2_E),
		.RD2_M(RD2_M),
		.IR_D(IR_D),
		.IR_E(IR_E),
		.IR_M(IR_M),
		.IR_W(IR_W),
		.M_RD1_D(M_RD1_D),
		.M_RD2_D(M_RD2_D),
		.M_RD1_E(M_RD1_E),
		.M_RD2_E(M_RD2_E),
		.M_RD2_M(M_RD2_M)
	);
	Analysis_MUX my_Analysis_MUX(
		.E_A3_Op(E_A3_Op),
		.M_A3_Op(M_A3_Op),
		.W_A3_Op(W_A3_Op),
		.E_WD_Op(E_WD_Op),
		.M_WD_Op(M_WD_Op),
		.W_WD_Op(W_WD_Op),
		.IR_E(IR_E),
		.IR_M(IR_M),
		.IR_W(IR_W),
		.PC8_E(PC8_E),
		.PC8_M(PC8_M),
		.PC8_W(PC8_W),
		.ALU_M(ALU_M),
		.ALU_W(ALU_W),
		.DM_W(DM_W),
		.HI(HI),
		.LO(LO),
		.E_A3(E_A3),
		.M_A3(M_A3),
		.W_A3(W_A3),
		.E_WD(E_WD),
		.M_WD(M_WD),
		.W_WD(W_WD)
	);
///////////// the end of MUX/FORWARDING/ADVENTURE/ANALYSIS

endmodule

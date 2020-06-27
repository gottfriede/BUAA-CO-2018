`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:48 11/18/2019 
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
	input [4:0] rt,
    output reg [3:0] ALUOp,
    output reg [1:0] GRFA3_MUXOp,
    output reg ALUB_MUXOp,
	output reg GRFWE,
    output reg DMWE,
    output reg [2:0] GRFWD_MUXOp,
    output reg [1:0] EXTOp,
    output reg is_B,
    output reg is_J,
    output reg [1:0] PCOp,
	output reg [2:0] Tuse_rs,
	output reg [2:0] Tuse_rt,
	output reg [2:0] Tnew,
	output reg [1:0] A3_Op,
	output reg [2:0] WD_Op,
	output reg ALUA_MUXOp,
	output reg [2:0] CMPOp,
	output reg [1:0] DMOp,
	output reg [2:0] DMEXTOp,
	output reg [2:0] XALUOp,
	output reg START
    );

	wire add,addu,sub,subu,sll,srl,sra,sllv,srlv,srav,andd,orr,xorr,norr,slt,sltu;
	wire addi,addiu,andi,ori,xori,lui,slti,sltiu;
	wire beq,bne,blez,bgtz,bltz,bgez,j,jal,jalr,jr;
	wire lb,lbu,lh,lhu,lw,sb,sh,sw;
	wire mult,multu,div,divu,mfhi,mflo,mthi,mtlo;
	
	assign add   = (opcode==6'b000000&&func==6'b100000) ? 1 : 0;
	assign addu  = (opcode==6'b000000&&func==6'b100001) ? 1 : 0;
	assign sub   = (opcode==6'b000000&&func==6'b100010) ? 1 : 0;
	assign subu  = (opcode==6'b000000&&func==6'b100011) ? 1 : 0;
	assign sll   = (opcode==6'b000000&&func==6'b000000) ? 1 : 0;
	assign srl   = (opcode==6'b000000&&func==6'b000010) ? 1 : 0;
	assign sra   = (opcode==6'b000000&&func==6'b000011) ? 1 : 0;
	assign sllv  = (opcode==6'b000000&&func==6'b000100) ? 1 : 0;
	assign srlv  = (opcode==6'b000000&&func==6'b000110) ? 1 : 0;
	assign srav  = (opcode==6'b000000&&func==6'b000111) ? 1 : 0;
	assign andd  = (opcode==6'b000000&&func==6'b100100) ? 1 : 0;
	assign orr   = (opcode==6'b000000&&func==6'b100101) ? 1 : 0;
	assign xorr  = (opcode==6'b000000&&func==6'b100110) ? 1 : 0;
	assign norr  = (opcode==6'b000000&&func==6'b100111) ? 1 : 0;
	assign slt   = (opcode==6'b000000&&func==6'b101010) ? 1 : 0;
	assign sltu  = (opcode==6'b000000&&func==6'b101011) ? 1 : 0;
	
	assign addi  = (opcode==6'b001000) ? 1 : 0;
	assign addiu = (opcode==6'b001001) ? 1 : 0;
	assign andi  = (opcode==6'b001100) ? 1 : 0;
	assign ori   = (opcode==6'b001101) ? 1 : 0;
	assign xori  = (opcode==6'b001110) ? 1 : 0;
	assign lui   = (opcode==6'b001111) ? 1 : 0;
	assign slti  = (opcode==6'b001010) ? 1 : 0;
	assign sltiu = (opcode==6'b001011) ? 1 : 0;
	
	assign beq   = (opcode==6'b000100) ? 1 : 0;
	assign bne   = (opcode==6'b000101) ? 1 : 0;
	assign blez  = (opcode==6'b000110) ? 1 : 0;
	assign bgtz  = (opcode==6'b000111) ? 1 : 0;
	assign bltz  = (opcode==6'b000001&&rt==5'b00000) ? 1 : 0;
	assign bgez  = (opcode==6'b000001&&rt==5'b00001) ? 1 : 0;
	assign j     = (opcode==6'b000010) ? 1 : 0;
	assign jal   = (opcode==6'b000011) ? 1 : 0;
	assign jalr  = (opcode==6'b000000&&func==6'b001001) ? 1 : 0;
	assign jr    = (opcode==6'b000000&&func==6'b001000) ? 1 : 0;
	
	assign lb    = (opcode==6'b100000) ? 1 : 0;
	assign lbu   = (opcode==6'b100100) ? 1 : 0;
	assign lh    = (opcode==6'b100001) ? 1 : 0;
	assign lhu   = (opcode==6'b100101) ? 1 : 0;
	assign lw    = (opcode==6'b100011) ? 1 : 0;
	assign sb    = (opcode==6'b101000) ? 1 : 0;
	assign sh    = (opcode==6'b101001) ? 1 : 0;
	assign sw    = (opcode==6'b101011) ? 1 : 0;
	
	assign mult  = (opcode==6'b000000&&func==6'b011000) ? 1 : 0;
	assign multu = (opcode==6'b000000&&func==6'b011001) ? 1 : 0;
	assign div   = (opcode==6'b000000&&func==6'b011010) ? 1 : 0;
	assign divu  = (opcode==6'b000000&&func==6'b011011) ? 1 : 0;
	assign mfhi  = (opcode==6'b000000&&func==6'b010000) ? 1 : 0;
	assign mflo  = (opcode==6'b000000&&func==6'b010010) ? 1 : 0;
	assign mthi  = (opcode==6'b000000&&func==6'b010001) ? 1 : 0;
	assign mtlo  = (opcode==6'b000000&&func==6'b010011) ? 1 : 0;

	always @ ( * ) begin
		if (add) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE       <= 1'b1;
			DMWE        <= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp       <= 2'b00;
			is_B        <= 1'b0;
			ALUOp       <= 4'b0010;
			is_J        <= 1'b0;
			PCOp        <= 2'b00;
			Tuse_rs     <= 3'b001;
			Tuse_rt     <= 3'b001;
			Tnew        <= 3'b010;
			A3_Op       <= 2'b00;
			WD_Op       <= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (addu) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sub) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0011;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (subu) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0011;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sll) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0100;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b101;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b1;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (srl) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0101;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b101;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b1;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sra) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0110;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b101;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b1;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sllv) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0100;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (srlv) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0101;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (srav) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0110;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (andd) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (orr) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0001;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (xorr) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0111;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (norr) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b1000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (slt) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b1001;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sltu) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp	<= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b1010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (addi) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp	<= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (addiu) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp	<= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (andi) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp	<= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b01;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (ori) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b01;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0001;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (xori) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b01;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0111;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (lui) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b10;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (slti) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b1001;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sltiu) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b1010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b001;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (beq) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b1;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b000;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (bne) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b1;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b000;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b001;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (blez) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b1;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b011;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (bgtz) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b1;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b100;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (bltz) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b1;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b010;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (bgez) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b1;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b101;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (j) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b1;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b101;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (jal) begin
			GRFA3_MUXOp <= 2'b10;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b010;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b1;
			PCOp 		<= 2'b10;
			Tuse_rs 	<= 3'b101;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b10;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (jalr) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b010;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b01;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (jr) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b01;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sw) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b1;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b010;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sh) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b1;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b010;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b01;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (sb) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b1;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b010;
			Tnew 		<= 3'b000;
			A3_Op 		<= 2'b00;
			WD_Op		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b10;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (lw) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b001;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b010;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (lh) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b001;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b010;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b001;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (lhu) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b001;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b010;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b010;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (lb) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b001;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b010;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b011;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (lbu) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b1;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b001;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0010;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b01;
			WD_Op 		<= 3'b010;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b100;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (mult) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b1;
		end
		else if (multu) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b001;
			START		<= 1'b1;
		end
		else if (div) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b010;
			START		<= 1'b1;
		end
		else if (divu) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b001;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b011;
			START		<= 1'b1;
		end
		else if (mthi) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b100;
			START		<= 1'b0;
		end
		else if (mtlo) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b001;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b010;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b101;
			START		<= 1'b0;
		end
		else if (mfhi) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b011;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b000;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b011;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else if (mflo) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b1;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b100;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b000;
			Tuse_rt 	<= 3'b000;
			Tnew 		<= 3'b011;
			A3_Op 		<= 2'b00;
			WD_Op 		<= 3'b100;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
			XALUOp		<= 3'b000;
			START		<= 1'b0;
		end
		else begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp  <= 1'b0;
			GRFWE 		<= 1'b0;
			DMWE 		<= 1'b0;
			GRFWD_MUXOp <= 3'b000;
			EXTOp 		<= 2'b00;
			is_B 		<= 1'b0;
			ALUOp 		<= 4'b0000;
			is_J 		<= 1'b0;
			PCOp 		<= 2'b00;
			Tuse_rs 	<= 3'b101;
			Tuse_rt 	<= 3'b101;
			Tnew 		<= 3'b000;
			A3_Op		<= 2'b00;
			WD_Op		<= 3'b000;
			ALUA_MUXOp  <= 1'b0;
			CMPOp		<= 3'b000;
			DMOp		<= 2'b00;
			DMEXTOp		<= 3'b000;
		end
	end

endmodule

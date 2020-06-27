`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:28 11/30/2019 
// Design Name: 
// Module Name:    Analysis_MUX 
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
module Analysis_MUX(
	input [1:0] E_A3_Op,
	input [1:0] M_A3_Op,
	input [1:0] W_A3_Op,
	input [2:0] E_WD_Op,
	input [2:0] M_WD_Op,
	input [2:0] W_WD_Op,
	input [31:0] IR_E,
	input [31:0] IR_M,
	input [31:0] IR_W,
	input [31:0] PC8_E,
	input [31:0] PC8_M,
	input [31:0] PC8_W,
	input [31:0] ALU_M,
	input [31:0] ALU_W,
	input [31:0] DM_W,
	input [31:0] HI,
	input [31:0] LO,
	output [4:0] E_A3,
	output [4:0] M_A3,
	output [4:0] W_A3,
	output [31:0] E_WD,
	output [31:0] M_WD,
	output [31:0] W_WD
    );
	
	wire [4:0] Erd;
	wire [4:0] Ert;
	wire [4:0] Mrd;
	wire [4:0] Mrt;
	wire [4:0] Wrd;
	wire [4:0] Wrt;
	assign Erd = IR_E[15:11];
	assign Ert = IR_E[20:16];
	assign Mrd = IR_M[15:11];
	assign Mrt = IR_M[20:16];
	assign Wrd = IR_W[15:11];
	assign Wrt = IR_W[20:16];
	
	assign E_A3 = (E_A3_Op==2'b00) ? Erd :
				  (E_A3_Op==2'b01) ? Ert :
				  (E_A3_Op==2'b10) ? 5'h1f :
									 5'b00000 ;
									 
	assign M_A3 = (M_A3_Op==2'b00) ? Mrd :
				  (M_A3_Op==2'b01) ? Mrt :
				  (M_A3_Op==2'b10) ? 5'h1f :
									 5'b00000 ;
									 
	assign W_A3 = (W_A3_Op==2'b00) ? Wrd :
				  (W_A3_Op==2'b01) ? Wrt :
				  (W_A3_Op==2'b10) ? 5'h1f :
									 5'b00000 ;
									 
	assign E_WD = (E_WD_Op==3'b000) ? PC8_E :
				  (E_WD_Op==3'b011) ? HI :
				  (E_WD_Op==3'b100) ? LO :
									 32'h00000000;
									 
	assign M_WD = (M_WD_Op==3'b000) ? PC8_M :
				  (M_WD_Op==3'b001) ? ALU_M :
				  (M_WD_Op==3'b011) ? HI :
				  (M_WD_Op==3'b100) ? LO :
									 32'h00000000;
	
	assign W_WD = (W_WD_Op==3'b000) ? PC8_W :
				  (W_WD_Op==3'b001) ? ALU_W :
				  (W_WD_Op==3'b010) ? DM_W :
				  (W_WD_Op==3'b011) ? HI :
				  (W_WD_Op==3'b100) ? LO :
									 32'h00000000;
endmodule

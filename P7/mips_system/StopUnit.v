`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:35 11/30/2019 
// Design Name: 
// Module Name:    StopUnit 
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
module StopUnit(
	input [2:0] Tuse_rs,
	input [2:0] Tuse_rt,
	input [2:0] Tnew_E,
	input [2:0] Tnew_M,
	input [4:0] E_A3,
	input [4:0] M_A3,
	input [31:0] IR_D,
	input [31:0] IR_E,
	input [31:0] IR_M,
	input BUSY,
	output D_en,
	output E_clr,
	output PC_en
    );

	wire stop;
	wire stop_md;
	wire stop_eret;
	wire [4:0] Drs;
	wire [4:0] Drt;
	assign Drs = IR_D[25:21];
	assign Drt = IR_D[20:16];
	
	wire md_D;
	wire md_E;
	
	assign md_D = ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b011000) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b011001) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b011010) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b011011) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b010000) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b010010) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b010001) )||
				  ( (IR_D[31:26]==6'b000000&&IR_D[5:0]==6'b010011) ) ;
				  
	assign md_E = ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b011000) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b011001) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b011010) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b011011) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b010000) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b010010) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b010001) )||
				  ( (IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b010011) ) ;
	
	assign stop_md = ((BUSY==1)||md_E)&&(md_D);
	assign stop_eret = (IR_D==32'h42000018)&&((IR_E[31:21]==11'b01000000100)||IR_M[31:21]==11'b01000000100);
	
	assign stop = ( Tuse_rs<Tnew_E&&E_A3==Drs&&Drs!=5'b00000 )||
				  ( Tuse_rs<Tnew_M&&M_A3==Drs&&Drs!=5'b00000 )||
				  ( Tuse_rt<Tnew_E&&E_A3==Drt&&Drt!=5'b00000 )||
				  ( Tuse_rt<Tnew_M&&M_A3==Drt&&Drt!=5'b00000 )||
				  stop_md || stop_eret;
				  
	assign D_en = !stop;
	assign E_clr = stop;
	assign PC_en = !stop;

endmodule

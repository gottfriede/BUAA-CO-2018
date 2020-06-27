`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:27 11/17/2019 
// Design Name: 
// Module Name:    Adventure 
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
module Adventure(
    input [31:0] E_WD,
    input [31:0] M_WD,
    input [31:0] W_WD,
	input [4:0] E_A3,
	input [4:0] M_A3,
	input [4:0] W_A3,
	input GRFWE_E,
	input GRFWE_M,
	input GRFWE_W,
    input [31:0] RD1,
	input [31:0] RD2,
	input [31:0] RD1_E,
	input [31:0] RD2_E,
	input [31:0] RD2_M,
	input [31:0] IR_D,
	input [31:0] IR_E,
	input [31:0] IR_M,
	input [31:0] IR_W,
	output [31:0] M_RD1_D,
	output [31:0] M_RD2_D,
	output [31:0] M_RD1_E,
	output [31:0] M_RD2_E,
	output [31:0] M_RD2_M
    );
	
	wire [4:0] Drs;
	wire [4:0] Drt;
	wire [4:0] Ers;
	wire [4:0] Ert;
	wire [4:0] Mrt;
	assign Drs = IR_D[25:21];
	assign Drt = IR_D[20:16];
	assign Ers = IR_E[25:21];
	assign Ert = IR_E[20:16];
	assign Mrt = IR_M[20:16];

	assign M_RD1_D = ( GRFWE_E&&E_A3==Drs&&Drs!=0 ) ? E_WD :
					 ( GRFWE_M&&M_A3==Drs&&Drs!=0 ) ? M_WD :
					 ( GRFWE_W&&W_A3==Drs&&Drs!=0 ) ? W_WD :
													  RD1  ;
	
	assign M_RD2_D = ( GRFWE_E&&E_A3==Drt&&Drt!=0 ) ? E_WD :
					 ( GRFWE_M&&M_A3==Drt&&Drt!=0 ) ? M_WD :
					 ( GRFWE_W&&W_A3==Drt&&Drt!=0 ) ? W_WD :
													  RD2  ;
	
	assign M_RD1_E = ( GRFWE_M&&M_A3==Ers&&Ers!=0 ) ? M_WD :
					 ( GRFWE_W&&W_A3==Ers&&Ers!=0 ) ? W_WD :
													  RD1_E ;
	
	assign M_RD2_E = ( GRFWE_M&&M_A3==Ert&&Ert!=0 ) ? M_WD :
					 ( GRFWE_W&&W_A3==Ert&&Ert!=0 ) ? W_WD :
													  RD2_E ;
	
	assign M_RD2_M = ( GRFWE_W&&W_A3==Mrt&&Mrt!=0 ) ? W_WD :
													  RD2_M ;

endmodule

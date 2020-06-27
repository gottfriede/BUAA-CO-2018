`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:49 12/07/2019 
// Design Name: 
// Module Name:    BRIDGE 
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
module BRIDGE(
    input [31:0] PrAddr,
	input [31:0] PrWD,
	input PrWE,
	input [31:0] DEV0RD,
	input [31:0] DEV1RD,
	output [31:0] PrRD,
	output [31:0] DEVAddr,
	output [31:0] DEVWD,
	output DEV0WE,
	output DEV1WE
    );
	
	//output the address and data
	assign DEVAddr = PrAddr;
	assign DEVWD = PrWD;
	
	//match the address
	wire HITDEV0;
	wire HITDEV1;
	assign HITDEV0 = ( PrAddr[31:4]==28'h00007F0 ) ? 1 : 0;
	assign HITDEV1 = ( PrAddr[31:4]==28'h00007F1 ) ? 1 : 0;
	
	//CPU read data from DEV
	assign PrRD = ( HITDEV0 ) ? DEV0RD :
				  ( HITDEV1 ) ? DEV1RD :
								32'h18373584;
	
	//CPU write data to DEV
	assign DEV0WE = PrWE && HITDEV0;
	assign DEV1WE = PrWE && HITDEV1;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:21 11/17/2019 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input [31:0] PC,
    input [31:0] DMA,
    input [31:0] DMD,
    input DMWE,
	input [1:0] DMOp,
    output [31:0] DM
    );

	integer i;
	reg[31:0] DMR[0:4095];
	assign DM = DMR[DMA[13:2]];
	
	initial begin
		for (i=0;i<4096;i=i+1) begin
			DMR[i] = 0;
		end
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			for (i=0;i<1024;i=i+1) begin
				DMR[i] <= 0;
			end
		end
		
		else if (DMWE==1&&DMOp==2'b00) begin		
			DMR[DMA[13:2]] <= DMD;
			$display("%d@%h: *%h <= %h",$time,PC, DMA,DMD);
		end
		
		else if (DMWE==1&&DMOp==2'b01) begin
			if (DMA[1]==1'b0) begin
				DMR[DMA[13:2]][15:0] <= DMD[15:0];
				$display("%d@%h: *%h <= %h",$time,PC, {DMA[31:2],2'b00},{DMR[DMA[13:2]][31:16],DMD[15:0]});
			end
			else if (DMA[1]==1'b1) begin
				DMR[DMA[13:2]][31:16] <= DMD[15:0];
				$display("%d@%h: *%h <= %h",$time,PC, {DMA[31:2],2'b00},{DMD[15:0],DMR[DMA[13:2]][15:0]});
			end
		end
		
		else if (DMWE==1&&DMOp==2'b10) begin
			if (DMA[1:0]==2'b00) begin
				DMR[DMA[13:2]][7:0] <= DMD[7:0];
				$display("%d@%h: *%h <= %h",$time,PC, {DMA[31:2],2'b00},{DMR[DMA[13:2]][31:8],DMD[7:0]});
			end
			else if (DMA[1:0]==2'b01) begin
				DMR[DMA[13:2]][15:8] <= DMD[7:0];
				$display("%d@%h: *%h <= %h",$time,PC, {DMA[31:2],2'b00},{DMR[DMA[13:2]][31:16],DMD[7:0],DMR[DMA[13:2]][7:0]});
			end
			else if (DMA[1:0]==2'b10) begin
				DMR[DMA[13:2]][23:16] <= DMD[7:0];
				$display("%d@%h: *%h <= %h",$time,PC, {DMA[31:2],2'b00},{DMR[DMA[13:2]][31:24],DMD[7:0],DMR[DMA[13:2]][15:0]});
			end
			else if (DMA[1:0]==2'b11) begin
				DMR[DMA[13:2]][31:24] <= DMD[7:0];
				$display("%d@%h: *%h <= %h",$time,PC, {DMA[31:2],2'b00},{DMD[7:0],DMR[DMA[13:2]][23:0]});
			end
		end
	end


endmodule

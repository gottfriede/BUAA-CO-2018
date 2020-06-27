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
	input [31:0] IR_M,
    output [31:0] DM,
	output [4:0] exccode_DM
    );

	wire chao;
	wire wcnt;
	assign chao = !( (DMA>=32'h00000000&&DMA<=32'h00002fff)||(DMA>=32'h00007f00&&DMA<=32'h00007f0b)||(DMA>=32'h00007f10&&DMA<=32'h00007f1b) );
	assign wcnt = ( (DMA>=32'h00007f08&&DMA<=32'h00007f0b)||(DMA>=32'h00007f18&&DMA<=32'h00007f1b) );
	
	assign exccode_DM = (IR_M[31:26]==6'b100011&&DMA[1:0]!=2'b00) ? 5'b00100 :
						(IR_M[31:26]==6'b100001&&DMA[0]  !=1'b0 ) ? 5'b00100 :
						(IR_M[31:26]==6'b100101&&DMA[0]  !=1'b0 ) ? 5'b00100 :
						(IR_M[31:26]==6'b100000&&DMA>=32'h00007f00&&DMA<=32'h00007f0b) ? 5'b00100 :
						(IR_M[31:26]==6'b100000&&DMA>=32'h00007f10&&DMA<=32'h00007f1b) ? 5'b00100 :
						(IR_M[31:26]==6'b100100&&DMA>=32'h00007f00&&DMA<=32'h00007f0b) ? 5'b00100 :
						(IR_M[31:26]==6'b100100&&DMA>=32'h00007f10&&DMA<=32'h00007f1b) ? 5'b00100 :
						(IR_M[31:26]==6'b100001&&DMA>=32'h00007f00&&DMA<=32'h00007f0b) ? 5'b00100 :
						(IR_M[31:26]==6'b100001&&DMA>=32'h00007f10&&DMA<=32'h00007f1b) ? 5'b00100 :
						(IR_M[31:26]==6'b100101&&DMA>=32'h00007f00&&DMA<=32'h00007f0b) ? 5'b00100 :
						(IR_M[31:26]==6'b100101&&DMA>=32'h00007f10&&DMA<=32'h00007f1b) ? 5'b00100 :
						(IR_M[31:26]==6'b100000&&chao) ? 5'b00100 :
						(IR_M[31:26]==6'b100100&&chao) ? 5'b00100 :
						(IR_M[31:26]==6'b100001&&chao) ? 5'b00100 :
						(IR_M[31:26]==6'b100101&&chao) ? 5'b00100 :
						(IR_M[31:26]==6'b100011&&chao) ? 5'b00100 :
						(IR_M[31:26]==6'b101011&&DMA[1:0]!=2'b00) ? 5'b00101 :
						(IR_M[31:26]==6'b101001&&DMA[0]  !=1'b0 ) ? 5'b00101 :
						(IR_M[31:26]==6'b101000&&DMA>=32'h00007f00&&DMA<=32'h00007f0b) ? 5'b00101 :
						(IR_M[31:26]==6'b101000&&DMA>=32'h00007f10&&DMA<=32'h00007f1b) ? 5'b00101 :
						(IR_M[31:26]==6'b101001&&DMA>=32'h00007f00&&DMA<=32'h00007f0b) ? 5'b00101 :
						(IR_M[31:26]==6'b101001&&DMA>=32'h00007f10&&DMA<=32'h00007f1b) ? 5'b00101 :
						(IR_M[31:26]==6'b101011&&wcnt) ? 5'b00101 :
						(IR_M[31:26]==6'b101000&&chao) ? 5'b00101 :
						(IR_M[31:26]==6'b101001&&chao) ? 5'b00101 :
						(IR_M[31:26]==6'b101011&&chao) ? 5'b00101 :
														 5'b00000 ;
						
	
	
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
		else if (exccode_DM==5'b00000) begin
			if (DMWE==1&&DMOp==2'b00&&DMA[1:0]==2'b00) begin		
				DMR[DMA[13:2]] <= DMD;
				$display("%d@%h: *%h <= %h",$time,PC, DMA,DMD);
			end
			
			else if (DMWE==1&&DMOp==2'b01&&DMA[0]==1'b0) begin
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
	end


endmodule

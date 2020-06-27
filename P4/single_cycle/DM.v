`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:02 11/09/2019 
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
	input [31:0] PC,
    input [31:0] DMA,
    input [31:0] DMD,
    input DMWE,
    input clk,
    input reset,
    output [31:0] DM
    );

	integer i;
	reg[31:0] DMR[0:1023];
	assign DM = DMR[DMA[11:2]];
	
	initial begin
		for (i=0;i<1024;i=i+1) begin
			DMR[i] = 0;
		end
	end
	
	always @(posedge clk) begin
		if (reset == 1) begin
			for (i=0;i<1024;i=i+1) begin
				DMR[i] <= 0;
			end
		end
		else if (DMWE==1) begin
			DMR[DMA[11:2]] <= DMD;
			$display("@%h: *%h <= %h",PC, DMA,DMD);
		end
	end

endmodule

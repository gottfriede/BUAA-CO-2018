`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:01:00 12/01/2019 
// Design Name: 
// Module Name:    DMEXT 
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
module DMEXT(
    input [31:0] DM,
    input [31:0] DMA,
    input [2:0] DMEXTOp,
    output reg [31:0] DMEXT
    );

	always @( * ) begin
		if (DMEXTOp==3'b000) begin
			DMEXT <= DM;
		end
		
		else if (DMEXTOp==3'b001) begin
			if (DMA[1]==1'b1) begin
				DMEXT <= {{16{DM[31]}},DM[31:16]};
			end
			else if (DMA[1]==1'b0) begin
				DMEXT <= {{16{DM[15]}},DM[15:0]};
			end
		end
		
		else if (DMEXTOp==3'b010) begin
			if (DMA[1]==1'b1) begin
				DMEXT <= {16'h0000,DM[31:16]};
			end
			else if (DMA[1]==1'b0) begin
				DMEXT <= {16'h0000,DM[15:0]};
			end
		end
		
		else if (DMEXTOp==3'b011) begin
			if (DMA[1:0]==2'b00) begin
				DMEXT <= {{24{DM[7]}},DM[7:0]};
			end
			else if (DMA[1:0]==2'b01) begin
				DMEXT <= {{24{DM[15]}},DM[15:8]};
			end
			else if (DMA[1:0]==2'b10) begin
				DMEXT <= {{24{DM[23]}},DM[23:16]};
			end
			else if (DMA[1:0]==2'b11) begin
				DMEXT <= {{24{DM[31]}},DM[31:24]};
			end
		end
		
		else if (DMEXTOp==3'b100) begin
			if (DMA[1:0]==2'b00) begin
				DMEXT <= {24'h000000,DM[7:0]};
			end
			else if (DMA[1:0]==2'b01) begin
				DMEXT <= {24'h000000,DM[15:8]};
			end
			else if (DMA[1:0]==2'b10) begin
				DMEXT <= {24'h000000,DM[23:16]};
			end
			else if (DMA[1:0]==2'b11) begin
				DMEXT <= {24'h000000,DM[31:24]};
			end
		end
	end

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:41:21 11/18/2019 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] ADD4,
    input [31:0] PC4_D,
    input [25:0] imm_index,
    input [31:0] M_RD1_D,
    input CMP,
    input is_B,
    input is_J,
    input [1:0] PCOp,
	input IntReq,
	input [31:0] EPC,
    output reg [31:0] TURE_NPC
    );

	reg [31:0] NPC;
	always @ ( * ) begin
		if (is_B&&CMP) begin
			NPC <= PC4_D + { {14{imm_index[15]}},imm_index[15:0],2'b00 };
		end
		else if (is_J) begin
			NPC <= { PC4_D[31:28],imm_index[25:0],2'b00 };
		end
		else begin
			NPC <= PC4_D + 4;
		end
		
		if (IntReq) begin
			TURE_NPC <= 32'h00004180;
		end
		else begin
			case (PCOp)
				2'b00: TURE_NPC <= ADD4;
				2'b01: TURE_NPC <= M_RD1_D;
				2'b10: TURE_NPC <= NPC;
				2'b11: TURE_NPC <= EPC;
				default: TURE_NPC <= 32'h00003000;
			endcase
		end
		
	end

endmodule

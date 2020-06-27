`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:23 11/09/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] ALUA,
    input [31:0] ALUB,
    input [2:0] ALUOp,
    output [31:0] ALU
    );

	parameter add_Op = 3'b001,
					sub_Op = 3'b010,
					orr_Op = 3'b011;
					
	reg[31:0] ALUOUT;				
	assign ALU = ALUOUT;
	
	always@ ( * ) begin
		case (ALUOp)
			add_Op:
				ALUOUT <= ALUA + ALUB;
			sub_Op:
				ALUOUT <= ALUA - ALUB;
			orr_Op:
				ALUOUT <= ALUA | ALUB;
			default:
				ALUOUT <= 32'h00000000;
		endcase
	end

endmodule

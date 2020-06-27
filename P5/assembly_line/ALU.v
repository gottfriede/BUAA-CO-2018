`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:11 11/17/2019 
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
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] ALUOUT
    );
	
	parameter andd_Op = 3'b000,
					orr_Op = 3'b001,
					add_Op = 3'b010,
					sub_Op = 3'b011;

	always @ ( * ) begin
		case (ALUOp)
			andd_Op: ALUOUT <= A & B;
			orr_Op: ALUOUT <= A | B;
			add_Op: ALUOUT <= A + B;
			sub_Op: ALUOUT <= A - B;
			default: ALUOUT <= 32'h00000000;
		endcase
	end

endmodule

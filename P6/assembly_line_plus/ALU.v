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
    input [3:0] ALUOp,
    output reg [31:0] ALUOUT
    );

	always @ ( * ) begin
		case (ALUOp)
			4'b0000: ALUOUT <= A & B;
			4'b0001: ALUOUT <= A | B;
			4'b0010: ALUOUT <= A + B;
			4'b0011: ALUOUT <= A - B;
			4'b0100: ALUOUT <= B << A[4:0];
			4'b0101: ALUOUT <= B >> A[4:0];
			4'b0110: ALUOUT <= $signed($signed(B) >>> A[4:0]);
			4'b0111: ALUOUT <= (~A & B)|(A & ~B);
			4'b1000: ALUOUT <= ~(A | B);
			4'b1001: ALUOUT <= ($signed(A)<$signed(B)) ? 32'h00000001 : 32'h00000000;
			4'b1010: ALUOUT <= (A < B) ? 32'h00000001 : 32'h00000000;
			default: ALUOUT <= 32'h00000000;
		endcase
	end

endmodule

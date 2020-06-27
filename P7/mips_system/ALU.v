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
	input [31:0] IR_E,
    output reg [31:0] ALUOUT,
	output [4:0] exccode_ALU
    );
	
	reg [32:0] temp;
	wire overflow;
	assign overflow = (temp[32]!=temp[31]);
	
	assign exccode_ALU = (overflow&&IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b100000) ? 5'b01100 :
						 (overflow&&IR_E[31:26]==6'b000000&&IR_E[5:0]==6'b100010) ? 5'b01100 :
						 (overflow&&IR_E[31:26]==6'b001000) 					  ? 5'b01100 :
						 (overflow&&IR_E[31:26]==6'b100000) 					  ? 5'b00100 :
						 (overflow&&IR_E[31:26]==6'b100100) 					  ? 5'b00100 :
						 (overflow&&IR_E[31:26]==6'b100001) 					  ? 5'b00100 :
						 (overflow&&IR_E[31:26]==6'b100101) 					  ? 5'b00100 :
						 (overflow&&IR_E[31:26]==6'b100011) 					  ? 5'b00100 :
						 (overflow&&IR_E[31:26]==6'b101000) 					  ? 5'b00101 :
						 (overflow&&IR_E[31:26]==6'b101001) 					  ? 5'b00101 :
						 (overflow&&IR_E[31:26]==6'b101011) 					  ? 5'b00101 :
																					5'b00000 ;
						 
						 
	
	always @ ( * ) begin
		case (ALUOp)
			4'b0000: ALUOUT <= A & B;
			4'b0001: ALUOUT <= A | B;
			4'b0010: begin
					 ALUOUT <= A + B;
					 temp <= {A[31],A[31:0]} + {B[31],B[31:0]};
					 end
			4'b0011: begin
					 ALUOUT <= A - B;
					 temp <= {A[31],A[31:0]} - {B[31],B[31:0]};
					 end
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

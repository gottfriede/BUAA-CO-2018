`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:48 11/18/2019 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [5:0] opcode,
    input [5:0] func,
    output reg [2:0] ALUOp,
    output reg [1:0] GRFA3_MUXOp,
    output reg ALUB_MUXOp,
	output reg GRFWE,
    output reg DMWE,
    output reg [1:0] GRFWD_MUXOp,
    output reg [1:0] EXTOp,
    output reg is_B,
    output reg is_J,
    output reg [1:0] PCOp
    );

	wire addu,subu,ori,lw,sw,beq,lui,jal,jr,j,nop;
	assign addu = (opcode==6'b000000&&func==6'b100001) ? 1: 0;
	assign subu = (opcode==6'b000000&&func==6'b100011) ? 1 : 0;
	assign ori = (opcode==6'b001101) ? 1 : 0;
	assign lw = (opcode==6'b100011) ? 1 : 0;
	assign sw = (opcode==6'b101011) ? 1 : 0;
	assign beq = (opcode==6'b000100) ? 1 : 0;
	assign lui = (opcode==6'b001111) ? 1 : 0;
	assign jal = (opcode==6'b000011) ? 1 : 0;
	assign jr = (opcode==6'b000000&&func==6'b001000) ? 1 : 0;
	assign j = (opcode==6'b000010) ? 1 : 0;

	always @ ( * ) begin
		if (addu) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b010;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
		else if (subu) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b011;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
		else if (ori) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b1;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b01;
			is_B <= 1'b0;
			ALUOp <= 3'b001;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
		else if (lui) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b1;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b10;
			is_B <= 1'b0;
			ALUOp <= 3'b010;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
		else if (lw) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b1;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b01;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b010;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
		else if (sw) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b1;
			GRFWE <= 1'b0;
			DMWE <= 1'b1;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b010;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
		else if (beq) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b0;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b1;
			ALUOp <= 3'b011;
			is_J <= 1'b0;
			PCOp <= 2'b10;
		end
		else if (j) begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b0;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b000;
			is_J <= 1'b1;
			PCOp <= 2'b10;
		end
		else if (jal) begin
			GRFA3_MUXOp <= 2'b10;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b10;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b000;
			is_J <= 1'b1;
			PCOp <= 2'b10;
		end
		else if (jr) begin
			GRFA3_MUXOp <= 2'b01;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b1;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b000;
			is_J <= 1'b0;
			PCOp <= 2'b01;
		end
		else begin
			GRFA3_MUXOp <= 2'b00;
			ALUB_MUXOp <= 1'b0;
			GRFWE <= 1'b0;
			DMWE <= 1'b0;
			GRFWD_MUXOp <= 2'b00;
			EXTOp <= 2'b00;
			is_B <= 1'b0;
			ALUOp <= 3'b000;
			is_J <= 1'b0;
			PCOp <= 2'b00;
		end
	end

endmodule

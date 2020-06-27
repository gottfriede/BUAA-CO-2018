`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:25 11/09/2019 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
    input [31:0] EXT,
    input [31:0] PC,
    input [25:0] index,
    input [31:0] RD1,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] ALU,
    input [31:0] DM,
    input [31:0] RD2,
    input [1:0] NPCIMM_MUXOp,
    input [1:0] GRFA3_MUXOp,
    input [1:0] GRFWD_MUXOp,
    input ALUB_MUXOp,
    output [31:0] NPCIMM,
    output [4:0] GRFA3,
    output [31:0] GRFWD,
    output [31:0] ALUB
    );
	
	reg[31:0] NPCIMMO;
	reg[4:0] GRFA3O;
	reg[31:0] GRFWDO;
	reg[31:0] ALUBO;
	assign NPCIMM = NPCIMMO;
	assign GRFA3 = GRFA3O;
	assign GRFWD = GRFWDO;
	assign ALUB = ALUBO;

	always @( * ) begin
		case (NPCIMM_MUXOp)
			2'b00 : NPCIMMO <= EXT;
			2'b01 : NPCIMMO <= {{PC[31:28]},{index[25:0]},2'b00};
			2'b10 : NPCIMMO <= RD1;
			default : NPCIMMO <= 32'h00000000;
		endcase
		
		case (GRFA3_MUXOp)
			2'b00 : GRFA3O <= rt;
			2'b01 : GRFA3O <= rd;
			2'b10 : GRFA3O <= 5'b11111;
			default : GRFA3O <= 5'b00000;
		endcase
		
		case (GRFWD_MUXOp)
			2'b00 : GRFWDO <= ALU;
			2'b01 : GRFWDO <= DM;
			2'b10 : GRFWDO <= EXT;
			2'b11 : GRFWDO <= PC + 4;
			default : GRFWDO <= 32'h00000000;
		endcase
		
		case (ALUB_MUXOp)
			1'b0 : ALUBO <= EXT;
			1'b1 : ALUBO <= RD2;
			default : ALUBO <= 32'h00000000;
		endcase
	end

endmodule

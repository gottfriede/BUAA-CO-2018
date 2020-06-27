`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:10 11/17/2019 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] D1,
    input [31:0] D2,
	input [2:0] CMPOp,
    output reg CMP
    );

	always @ ( * ) begin
		case (CMPOp)
		3'b000: CMP <= (D1==D2);
		3'b001: CMP <= (D1!=D2);
		3'b010: CMP <= (D1[31]==1);
		3'b011: CMP <= (D1[31]==1)||(D1==32'h00000000);
		3'b100: CMP <= (D1[31]==0)&&(D1!=32'h00000000);
		3'b101: CMP <= (D1[31]==0);
		endcase
	end
	
endmodule

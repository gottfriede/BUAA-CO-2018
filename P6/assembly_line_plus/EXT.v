`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:31 11/17/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] IMM,
    input [1:0] EXTOp,
    output reg [31:0] EXTOUT
    );
	
	parameter sign_Op = 2'b00,
			  zero_Op = 2'b01,
			  high_Op = 2'b10;
	
	always @ ( * ) begin
		case(EXTOp)
			sign_Op: EXTOUT <= {{16{IMM[15]}},IMM[15:0]};
			zero_Op: EXTOUT <= {{16{1'b0}},IMM[15:0]};
			high_Op: EXTOUT <= {IMM[15:0],{16{1'b0}}};
			default: EXTOUT <= 32'h00000000;
		endcase
	end

endmodule

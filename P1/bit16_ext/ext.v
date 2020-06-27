`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:35 10/18/2019 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );

wire [31:0]symbol_ext = { {16{imm[15]}} ,imm[15:0]};
wire [31:0]zero_ext = {16'b00000000_00000000,imm[15:0]};
wire [31:0]hi_ext = {imm[15:0],16'b00000000_00000000};
wire [31:0]sym_left_ext = symbol_ext << 2'b10;

assign ext = EOp[1] ? ( EOp[0] ? sym_left_ext : hi_ext )
						  : ( EOp[0] ? zero_ext : symbol_ext );

endmodule

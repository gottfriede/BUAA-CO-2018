`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:48 10/18/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output [31:0] C
    );

wire [31:0]ans = A + B;
wire [31:0]min = A - B;
wire [31:0]andd = A & B;
wire [31:0]orr = A | B;
wire [31:0]log = A >> B;
wire [31:0]sim = $signed(A) >>> B;

assign C = ALUOp[2] ? ( ALUOp[1] ? ( ALUOp[0] ? 0 : 0 ) 
								  : ( ALUOp[0] ? sim : log ) )
				 : ( ALUOp[1] ? ( ALUOp[0] ? orr : andd ) 
								  : ( ALUOp[0] ? min : ans ) );

endmodule

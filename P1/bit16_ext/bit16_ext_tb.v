`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:51:42 10/18/2019
// Design Name:   ext
// Module Name:   C:/Users/lenovo/Desktop/co/P1/bit16_ext/bit16_ext_tb.v
// Project Name:  bit16_ext
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ext
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bit16_ext_tb;

	// Inputs
	reg [15:0] imm;
	reg [1:0] EOp;

	// Outputs
	wire [31:0] ext;

	// Instantiate the Unit Under Test (UUT)
	ext uut (
		.imm(imm), 
		.EOp(EOp), 
		.ext(ext)
	);

	initial begin
		// Initialize Inputs
		imm = 0;
		EOp = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		imm = 16'b10011010_01001001;
		EOp = 2'b00;
		#100;
		EOp = 2'b01;
		#100;
		EOp = 2'b10;
		#100;
		EOp = 2'b11;
		// Add stimulus here

	end
      
endmodule


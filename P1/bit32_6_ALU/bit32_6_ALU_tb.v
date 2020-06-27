`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:09:39 10/18/2019
// Design Name:   alu
// Module Name:   C:/Users/lenovo/Desktop/co/P1/bit32_6_ALU/bit32_6_ALU_tb.v
// Project Name:  bit32_6_ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bit32_6_ALU_tb;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] ALUOp;

	// Outputs
	wire [31:0] C;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.A(A), 
		.B(B), 
		.ALUOp(ALUOp), 
		.C(C)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		ALUOp = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		A = 32'b11111110_00000000_00000000_01011101;
		B = 32'b00000010;
		ALUOp = 3'b000; 
		#100;
		ALUOp = 3'b001;
		#100;
		ALUOp = 3'b010;
		#100;
		ALUOp = 3'b011;
		#100;
		ALUOp = 3'b100;
		#100;
		ALUOp = 3'b101;
		// Add stimulus here

	end
      
endmodule


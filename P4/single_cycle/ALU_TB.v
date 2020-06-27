`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:02:02 11/09/2019
// Design Name:   ALU
// Module Name:   C:/Users/lenovo/Desktop/co/P4/single_cycle/ALU_TB.v
// Project Name:  single_cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_TB;

	// Inputs
	reg [31:0] ALUA;
	reg [31:0] ALUB;
	reg [2:0] ALUOp;

	// Outputs
	wire [31:0] ALU;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALUA(ALUA), 
		.ALUB(ALUB), 
		.ALUOp(ALUOp), 
		.ALU(ALU)
	);

	initial begin
		// Initialize Inputs
		ALUA = 0;
		ALUB = 0;
		ALUOp = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		ALUA = 32'b11111111111111111111111100001111;
		ALUB = 32'b01000000000000000000000000000000;
		ALUOp = 3'b001;
		#5; 
		ALUOp = 3'b010;
		#5;
		ALUOp = 3'b011;

	end
      
endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:52:18 11/09/2019
// Design Name:   EXT
// Module Name:   C:/Users/lenovo/Desktop/co/P4/single_cycle/EXT_TB.v
// Project Name:  single_cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: EXT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module EXT_TB;

	// Inputs
	reg [15:0] EXTIMM;
	reg [2:0] EXTOp;

	// Outputs
	wire [31:0] EXT;

	// Instantiate the Unit Under Test (UUT)
	EXT uut (
		.EXTIMM(EXTIMM), 
		.EXTOp(EXTOp), 
		.EXT(EXT)
	);

	initial begin
		// Initialize Inputs
		EXTIMM = 0;
		EXTOp = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		EXTIMM=32'b10001000100010001000100010001000;
		#5;
		EXTOp = 1;
		#5;
		EXTOp = 2;
		#5;
		EXTOp = 3;
		#5;
		EXTOp = 4;
		

	end
      
endmodule


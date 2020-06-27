`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:47:30 11/09/2019
// Design Name:   DM
// Module Name:   C:/Users/lenovo/Desktop/co/P4/single_cycle/DM_TB.v
// Project Name:  single_cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DM_TB;

	// Inputs
	reg [31:0] DMA;
	reg [31:0] DMD;
	reg DMWE;
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] DM;

	// Instantiate the Unit Under Test (UUT)
	DM uut (
		.DMA(DMA), 
		.DMD(DMD), 
		.DMWE(DMWE), 
		.clk(clk), 
		.reset(reset), 
		.DM(DM)
	);

	initial begin
		// Initialize Inputs
		DMA = 0;
		DMD = 0;
		DMWE = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		#2;
		DMWE = 1;
		DMA = 4;
		DMD = 1;
		#10;
		DMA=8;
		DMD=2;
		#10;
		DMA = 4;
		#10;
		reset = 1;
		DMWE = 0;

	end
	
	always #5 begin
		clk = ~clk;
	end
      
endmodule


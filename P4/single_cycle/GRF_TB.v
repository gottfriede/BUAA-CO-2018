`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:25:58 11/09/2019
// Design Name:   GRF
// Module Name:   C:/Users/lenovo/Desktop/co/P4/single_cycle/GRF_TB.v
// Project Name:  single_cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GRF
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module GRF_TB;

	// Inputs
	reg [4:0] A1;
	reg [4:0] A2;
	reg [4:0] A3;
	reg [31:0] WD;
	reg WE;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] RD1;
	wire [31:0] RD2;

	// Instantiate the Unit Under Test (UUT)
	GRF uut (
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.WD(WD), 
		.WE(WE), 
		.reset(reset), 
		.clk(clk), 
		.RD1(RD1), 
		.RD2(RD2)
	);

	initial begin
		// Initialize Inputs
		A1 = 0;
		A2 = 0;
		A3 = 0;
		WD = 0;
		WE = 0;
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		#2;
		A1 = 0;
		A2 = 1;
		WE = 1;
		WD = 1;
		A3 = 0;
		#10;
		A3 = 1;
		#10;
		A3 = 29;
		WD = 2;
		#10;
		A3 = 5;
		WD = 3;
		#10;
		WE = 0;
		A1 = 5;
		A2 = 29;
		
		

	end
	
	always #5 clk = ~clk;
      
endmodule


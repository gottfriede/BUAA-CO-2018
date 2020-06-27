`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:26:17 10/18/2019
// Design Name:   gray
// Module Name:   C:/Users/lenovo/Desktop/co/P1/bit3_gray/bit3_gray_tb.v
// Project Name:  bit3_gray
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: gray
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bit3_gray_tb;

	// Inputs
	reg Clk;
	reg Reset;
	reg En;

	// Outputs
	wire [2:0] Output;
	wire Overflow;

	// Instantiate the Unit Under Test (UUT)
	gray uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.En(En), 
		.Output(Output), 
		.Overflow(Overflow)
	);

	initial begin
		// Initialize Inputs
		Clk = 0; 
		Reset = 0;
		En = 1;

		// Wait 100 ns for global reset to finish

		#1030;
		En = 0;
		
		// Add stimulus hereend
	end
	
      always #50
		Clk = ~Clk;
        
endmodule


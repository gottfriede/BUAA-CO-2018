`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:34:53 10/18/2019
// Design Name:   string
// Module Name:   C:/Users/lenovo/Desktop/co/P1/string_fsm/string_fsm_tb.v
// Project Name:  string_fsm
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: string
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module string_fsm_tb;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	string uut (
		.clk(clk), 
		.clr(clr), 
		.in(in),
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#8;
       
		clr = 0;
		in = 50;
		#10;
		in = 42;
		#10;
		in = 51;
		#10;
		in = 43;
		#10;
		in = 56;
		#10;
		in = 57;
		#10;
		in = 43;
		#10;
		clr = 1;
		#10;
		clr = 0;
		in = 50;
		#10;
		in = 42;
		#10;
		in = 43;
		#10; 
		// Add stimulus here

	end
      
	always #5 begin
		clk = ~clk;
	end

endmodule


`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:48 11/09/2019
// Design Name:   NPC
// Module Name:   C:/Users/lenovo/Desktop/co/P4/single_cycle/NPC_TB.v
// Project Name:  single_cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NPC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module NPC_TB;

	// Inputs
	reg [31:0] NPCI;
	reg [31:0] NPCIMM;
	reg [1:0] NPCOp;

	// Outputs
	wire [31:0] NPC;

	// Instantiate the Unit Under Test (UUT)
	NPC uut (
		.NPCI(NPCI), 
		.NPCIMM(NPCIMM), 
		.NPCOp(NPCOp), 
		.NPC(NPC)
	);

	initial begin
		// Initialize Inputs
		NPCI = 0;
		NPCIMM = 0;
		NPCOp = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		#2;
		NPCI = 1;
		NPCIMM=2;
		NPCOp = 2'b00;
		#10;
		NPCOp = 2'b01;
		#10;
		NPCOp = 2'b10;

	end
      
endmodule


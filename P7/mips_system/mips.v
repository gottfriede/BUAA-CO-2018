`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:36:28 12/07/2019 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
	input interrupt,
	output [31:0] addr
    );

	wire [31:0] PrAddr;
	wire [31:0] PrWD;
	wire [31:0] PrRD;
	wire [3:0] PrBE;
	wire PrWE;
	
	wire [31:0] DEV0RD;
	wire [31:0] DEV1RD;
	wire [31:0] DEVAddr;
	wire [31:0] DEVWD;
	wire DEV0WE;
	wire DEV1WE;
	wire DEV0IRQ;
	wire DEV1IRQ;
	wire [7:2] HWInt;
	
	assign HWInt = {3'b000,interrupt,DEV1IRQ,DEV0IRQ};
	
	CPU my_CPU(
		.clk(clk),
		.reset(reset),
		.PrRD(PrRD),
		.HWInt(HWInt),
		.PrAddr(PrAddr),
		.PrWD(PrWD),
		.PrWE(PrWE),
		.PrBE(PrBE),
		.addr(addr)
	);
	
	BRIDGE my_BRIDGE(
		.PrAddr(PrAddr),
		.PrWD(PrWD),
		.PrWE(PrWE),
		.DEV0RD(DEV0RD),
		.DEV1RD(DEV1RD),
		.PrRD(PrRD),
		.DEVAddr(DEVAddr),
		.DEVWD(DEVWD),
		.DEV0WE(DEV0WE),
		.DEV1WE(DEV1WE)
	);
	
	TC my_DEV0(
		.clk(clk),
		.reset(reset),
		.Addr(DEVAddr[31:2]),
		.WE(DEV0WE),
		.Din(DEVWD),
		.Dout(DEV0RD),
		.IRQ(DEV0IRQ)
	);
	
	TC my_DEV1(
		.clk(clk),
		.reset(reset),
		.Addr(DEVAddr[31:2]),
		.WE(DEV1WE),
		.Din(DEVWD),
		.Dout(DEV1RD),
		.IRQ(DEV1IRQ)
	);

endmodule

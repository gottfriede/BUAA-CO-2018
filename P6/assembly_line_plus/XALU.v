`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:17:22 12/01/2019 
// Design Name: 
// Module Name:    XALU 
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
module XALU(
    input clk,
    input reset,
    input [31:0] XALUA,
    input [31:0] XALUB,
    input [2:0] XALUOp,
    input START,
    output reg BUSY,
    output [31:0] HIGH,
    output [31:0] LOW
    );

	reg [31:0] HI;
	reg [31:0] LO;
	reg [63:0] tmp;
	reg [31:0] t;
	
	assign HIGH = HI;
	assign LOW = LO;
	
	initial begin
		HI = 32'h00000000;
		LO = 32'h00000000;
		tmp = 64'h0000000000000000;
		BUSY = 1'b0;
		t = 32'h00000000;
	end
	
	always@(posedge clk) begin
		if(reset) begin
			HI <= 32'h00000000;
			LO <= 32'h00000000;
			tmp <= 64'h0000000000000000;
			BUSY <= 1'b0;
			t <= 32'h00000000;
		end
		else if(BUSY==1'b0) begin
			if(START) begin
				BUSY <= 1;
				case(XALUOp)
					3'b000: begin
						tmp <= $signed(XALUA)*$signed(XALUB);
						t <= 5;
					end
					3'b001: begin
						tmp <= XALUA*XALUB;
						t <= 5;
					end
					3'b010: begin
						tmp <= {$signed(XALUA)%$signed(XALUB),$signed(XALUA)/$signed(XALUB)};
						t <= 10;
					end
					3'b011: begin
						tmp <= {XALUA%XALUB,XALUA/XALUB};
						t <= 10;
					end
					default: begin
					end
				endcase
			end
			else if (XALUOp==3'b100) begin
				HI <= XALUA;
//				$display("%d@: $%d <= %h", $time,32,XALUA);
			end
			else if (XALUOp==3'b101) begin
				LO <= XALUA;
//				$display("%d@: $%d <= %h", $time,33,XALUA);
			end
		end
		else if(BUSY==1'b1) begin
			if(t>0) begin
				t = t-1;
				if(t==0) begin
					HI <= tmp[63:32];
//					$display("%d@: $%d <= %h", $time,32,tmp[63:32]);
					LO <= tmp[31:0];
//					$display("%d@: $%d <= %h", $time,33,tmp[31:0]);
					BUSY <= 0;
				end
			end
		end
	end

endmodule

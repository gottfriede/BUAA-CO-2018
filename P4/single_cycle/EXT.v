`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:18:45 11/09/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] EXTIMM,
    input [2:0] EXTOp,
    output [31:0] EXT
    );
	
	parameter zero_Op = 3'b001,
					sign_Op = 3'b010,
					sign_00_Op = 3'b011,
					high_Op = 3'b100;
	
	reg[31:0] EXTOUT;
	assign EXT = EXTOUT;

	always @( * ) begin
		case (EXTOp)
			zero_Op:
				EXTOUT <= {{16{1'b0}},EXTIMM[15:0]};
			sign_Op:
				EXTOUT <= {{16{EXTIMM[15]}},EXTIMM[15:0]};
			sign_00_Op:
				EXTOUT <= {{14{EXTIMM[15]}},EXTIMM[15:0],2'b00};
			high_Op:
				EXTOUT <= {EXTIMM[15:0],{16{1'b0}}};
			default:
				EXTOUT <= 32'h00000000;
		endcase
	end

endmodule

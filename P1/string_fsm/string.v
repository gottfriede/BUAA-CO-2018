`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:20:54 10/18/2019 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output reg out
    );

parameter s0 = 2'b0,
			 s1 = 2'b1;

reg state;
reg mistake;

initial begin
	out = 0;
	state = s0;
	mistake = 0;
//	$monitor("%04dns monitor:state=%d mistake=%d",$time,state,mistake);
end

always @(posedge clk,posedge clr) begin
	if (clr == 1) begin
		out <= 0;
		state <= s0;
		mistake <= 0;
	end
	
	else begin
		case (state)
		
		s0: begin
			if (in >=48 && in <= 57) begin
				state <= s1;
				if (mistake == 0)
					out <= 1;
			end
			else begin
				mistake <= 1;
			end
		end
		
		s1: begin
			out <= 0;
			if (in ==42 || in==43) begin
				state <= s0;
			end
			else begin
				mistake <= 1;
			end
		end
		
		default: begin
			mistake <= 1;
			out <= 0;
		end
		
		endcase
		
	end
end

endmodule

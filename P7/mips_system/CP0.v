`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:40 12/08/2019 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input [4:0] A1,			//读CP0寄存器编号
    input [4:0] A2,			//写CP0寄存器编号
    input [31:0] Din,		//
    input [31:2] PC,		//
    input [6:2] ExcCode,	//中断类型
    input [5:0] HWInt,		//外部设备中断
    input WE,				//CP0写使能
    input EXLSet,			//用于置位SR的EXL
    input EXLClr,			//用于清除SR的EXL
    input clk,				//
    input reset,			//
	input bd_M,
    output IntReq,			//中断请求
    output [31:2] EPC,		//
    output [31:0] Dout		//
    );
	
	//SR = {16'b0,im,8'b0,exl,ie}
	reg [15:10] im;			//6位中断屏蔽位，1-允许中断
	reg exl;				//异常级，1-进入异常，不允许中断
	reg ie;					//全局中断使能
	//CAUSE = {bd,15'b0,hwint_pend,3'b0,exccode,2'b0}
	reg bd;					//1-异常发生于延迟槽
	reg [6:2] exccode;		//
	reg [15:10] hwint_pend; //锁存外部中断
	reg [31:2] epc;
	reg [31:0] PRId = 32'h18373584;
	
	assign Dout = (A1==5'b01100) ? {16'b0,im,8'b0,exl,ie} :
				  (A1==5'b01101) ? {bd,15'b0,hwint_pend,3'b0,exccode,2'b00} :
				  (A1==5'b01110) ? {epc,2'b00} :
				  (A1==5'b01111) ? PRId :
								   32'h00000000;
	assign EPC = epc;
	
	
	wire zhongduan;
	assign zhongduan = (ie&&!exl&& ( |((HWInt[5:0])&im[15:10]) ) );
	assign IntReq = (ExcCode>0) || zhongduan;
	
	always @(posedge clk) begin
		if (reset) begin
			im <= 6'b000000;
			exl <= 1'b0;
			ie <= 1'b0;
			hwint_pend <= 6'b000000;
			bd <= 1'b0;
			exccode <= 5'b00000;
			epc <= 30'b0;
		end
		else begin
			hwint_pend <= HWInt;
			if (WE) begin
				if (A2==5'b01100) begin
					{im,exl,ie} <= {Din[15:10],Din[1],Din[0]};
				end
				if (A2==5'b01101) begin
					hwint_pend <= Din[15:10];
				end
				if (A2==5'b01110) begin
					epc <= Din[31:2];
				end
				if (A2==5'b01111) begin
					PRId <= Din;
				end
			end
			if (zhongduan) begin
				exl <= 1'b1;
				exccode <= 5'b00000;
			end
			else if (EXLSet||(IntReq&&!zhongduan)) begin
				exl <= 1'b1;
				exccode <= ExcCode;
			end
			if (EXLClr) begin
				exl <= 1'b0;
			end
			if (IntReq) begin
				bd <= bd_M;
			epc <= (IntReq&&bd_M) ? PC - 1 :
				   (IntReq&&!bd_M)? PC     :
								  epc;
			end
		end
	end

endmodule

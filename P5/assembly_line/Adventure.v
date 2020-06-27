`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:27 11/17/2019 
// Design Name: 
// Module Name:    Adventure 
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
module Adventure(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
    output D_en,
    output E_clr,
    output PC_en,
	output [2:0] M_RD1_D_Op,
	output [2:0] M_RD2_D_Op,
	output [2:0] M_RD1_E_Op,
	output [2:0] M_RD2_E_Op,
	output [2:0] M_RD2_M_Op
    );

	wire [5:0] Dopcode;
	wire [4:0] Drs;
	wire [4:0] Drt;
	wire [4:0] Drd;
	wire [4:0] Dshamt;
	wire [5:0] Dfunc;
	wire [15:0] Dimm;
	wire [5:0] Eopcode;
	wire [4:0] Ers;
	wire [4:0] Ert;
	wire [4:0] Erd;
	wire [4:0] Eshamt;
	wire [5:0] Efunc;
	wire [15:0] Eimm;
	wire [5:0] Mopcode;
	wire [4:0] Mrs;
	wire [4:0] Mrt;
	wire [4:0] Mrd;
	wire [4:0] Mshamt;
	wire [5:0] Mfunc;
	wire [15:0] Mimm;
	wire [5:0] Wopcode;
	wire [4:0] Wrs;
	wire [4:0] Wrt;
	wire [4:0] Wrd;
	wire [4:0] Wshamt;
	wire [5:0] Wfunc;
	wire [15:0] Wimm;
	
	assign Dopcode = IR_D[31:26];
	assign Drs = IR_D[25:21];
	assign Drt = IR_D[20:16];
	assign Drd = IR_D[15:11];
	assign Dshamt = IR_D[10:6];
	assign Dfunc = IR_D[5:0];
	assign Dimm = IR_D[15:0];
	assign Eopcode = IR_E[31:26];
	assign Ers = IR_E[25:21];
	assign Ert = IR_E[20:16];
	assign Erd = IR_E[15:11];
	assign Eshamt = IR_E[10:6];
	assign Efunc = IR_E[5:0];
	assign Eimm = IR_E[15:0];
	assign Mopcode = IR_M[31:26];
	assign Mrs = IR_M[25:21];
	assign Mrt = IR_M[20:16];
	assign Mrd = IR_M[15:11];
	assign Mshamt = IR_M[10:6];
	assign Mfunc = IR_M[5:0];
	assign Wimm = IR_W[15:0];
	assign Wopcode = IR_W[31:26];
	assign Wrs = IR_W[25:21];
	assign Wrt = IR_W[20:16];
	assign Wrd = IR_W[15:11];
	assign Wshamt = IR_W[10:6];
	assign Wfunc = IR_W[5:0];
	assign Wimm = IR_W[15:0];
	
	parameter R = 6'b000000,
			  addu = 6'b100001,
			  subu = 6'b100011,
			  ori = 6'b001101,
			  lw = 6'b100011,
			  sw = 6'b101011,
			  beq = 6'b000100,
			  lui = 6'b001111,
			  jal = 6'b000011,
			  j = 6'b000010,
			  jr = 6'b001000;
	
	wire cal_r_D;
	wire cal_r_E;
	wire cal_r_M;
	wire cal_r_W;
	assign cal_r_D = (Dopcode==R&&Dfunc==addu)||(Dopcode==R&&Dfunc==subu);
	assign cal_r_E = (Eopcode==R&&Efunc==addu)||(Eopcode==R&&Efunc==subu);
	assign cal_r_M = (Mopcode==R&&Mfunc==addu)||(Mopcode==R&&Mfunc==subu);
	assign cal_r_W = (Wopcode==R&&Wfunc==addu)||(Wopcode==R&&Wfunc==subu);
	wire cal_i_D;
	wire cal_i_E;
	wire cal_i_M;
	wire cal_i_W;
	assign cal_i_D = (Dopcode==ori)||(Dopcode==lui);
	assign cal_i_E = (Eopcode==ori)||(Eopcode==lui);
	assign cal_i_M = (Mopcode==ori)||(Mopcode==lui);
	assign cal_i_W = (Wopcode==ori)||(Wopcode==lui);
	wire load_D;
	wire load_E;
	wire load_M;
	wire load_W;
	assign load_D = (Dopcode==lw);
	assign load_E = (Eopcode==lw);
	assign load_M = (Mopcode==lw);
	assign load_W = (Wopcode==lw);
	wire store_D;
	wire store_E;
	wire store_M;
	wire store_W;
	assign store_D = (Dopcode==sw);
	assign store_E = (Eopcode==sw);
	assign store_M = (Mopcode==sw);
	assign store_W = (Wopcode==sw);
	wire beq_D;
	wire beq_E;
	wire beq_M;
	wire beq_W;
	assign beq_D = (Dopcode==beq);
	assign beq_E = (Eopcode==beq);
	assign beq_M = (Mopcode==beq);
	assign beq_W = (Wopcode==beq);
	wire j_D;
	wire j_E;
	wire j_M;
	wire j_W;
	assign j_D = (Dopcode==j);
	assign j_E = (Eopcode==j);
	assign j_M = (Mopcode==j);
	assign j_W = (Wopcode==j);
	wire jal_D;
	wire jal_E;
	wire jal_M;
	wire jal_W;
	assign jal_D = (Dopcode==jal);
	assign jal_E = (Eopcode==jal);
	assign jal_M = (Mopcode==jal);
	assign jal_W = (Wopcode==jal);
	wire jr_D;
	wire jr_E;
	wire jr_M;
	wire jr_W;
	assign jr_D = (Dopcode==R&&Dfunc==jr);
	assign jr_E = (Eopcode==R&&Efunc==jr);
	assign jr_M = (Mopcode==R&&Mfunc==jr);
	assign jr_W = (Wopcode==R&&Wfunc==jr);
	
	wire stall_cal_r,stall_cal_i,stall_load,stall_store,stall_beq,stall_jr;
	
	assign stall_cal_r = (cal_r_D)&&(load_E)&&(Drs==Ert||Drt==Ert);
	assign stall_cal_i = (cal_i_D)&&(load_E)&&(Drs==Ert);
	assign stall_load = (load_D)&&(load_E)&&(Drs==Ert);
	assign stall_store = (store_D)&&(load_E)&&(Drs==Ert);
	assign stall_beq = ( (beq_D)&&(cal_r_E)&&(Drs==Erd||Drt==Erd) )||
					   ( (beq_D)&&(cal_i_E)&&(Drs==Ert||Drt==Ert) )||
					   ( (beq_D)&&(load_E)&&(Drs==Ert||Drt==Ert) )||
					   ( (beq_D)&&(load_M)&&(Drs==Mrt||Drt==Mrt) );
	assign stall_jr = ( (jr_D)&&(cal_r_E)&&(Drs==Erd) )||
					  ( (jr_D)&&(cal_i_E)&&(Drs==Ert) )||
					  ( (jr_D)&&(load_E)&&(Drs==Ert) )||
					  ( (jr_D)&&(load_M)&&(Drs==Mrt) );
	
	wire stall;
	assign stall = stall_cal_r||stall_cal_i||stall_load||stall_store||stall_beq||stall_jr;
	
	assign D_en = !stall;
	assign E_clr = stall;
	assign PC_en = !stall;
///////////////////////////////////////////////////////////////////////////////////////////	
	wire RS_D,RT_D,RS_E,RT_E,RT_M;
	assign RS_D = cal_r_D||cal_i_D||beq_D||load_D||store_D||jr_D;
	assign RT_D = cal_r_D||store_D||beq_D;
	assign RS_E = cal_r_E||cal_i_E||load_E||store_E;
	assign RT_E = cal_r_E||store_E;
	assign RT_M = store_M;
	
	assign M_RD1_D_Op = ( RS_D&&jal_E&&Drs==5'h1f ) ? 3 :
						( RS_D&&cal_r_M&&Drs==Mrd&&Drs!=0 ) ? 1 :
						( RS_D&&cal_i_M&&Drs==Mrt&&Drs!=0 ) ? 1 :
						( RS_D&&jal_M&&Drs==5'h1f ) ? 4 :
						( RS_D&&cal_r_W&&Drs==Wrd&&Drs!=0 ) ? 2 :
						( RS_D&&cal_i_W&&Drs==Wrt&&Drs!=0 ) ? 2 :
						( RS_D&&load_W&&Drs==Wrt&&Drs!=0 ) ? 2 :
						( RS_D&&jal_W&&Drs==5'h1f ) ? 5 : 0;
	
	assign M_RD2_D_Op = ( RT_D&&jal_E&&Drt==5'h1f ) ? 3 :
						( RT_D&&cal_r_M&&Drt==Mrd&&Drt!=0 ) ? 1 :
						( RT_D&&cal_i_M&&Drt==Mrt&&Drt!=0 ) ? 1 :
						( RT_D&&jal_M&&Drt==5'h1f ) ? 4 :
						( RT_D&&cal_r_W&&Drt==Wrd&&Drt!=0 ) ? 2 :
						( RT_D&&cal_i_W&&Drt==Wrt&&Drt!=0 ) ? 2 :
						( RT_D&&load_W&&Drt==Wrt&&Drt!=0 ) ? 2 :
						( RT_D&&jal_W&&Drt==5'h1f ) ? 5 : 0;
	
	assign M_RD1_E_Op = ( RS_E&&cal_r_M&&Ers==Mrd&&Ers!=0 ) ? 1 :
						( RS_E&&cal_i_M&&Ers==Mrt&&Ers!=0 ) ? 1 :
						( RS_E&&jal_M&&Ers==5'h1f ) ? 4 :
						( RS_E&&cal_r_W&&Ers==Wrd&&Ers!=0 ) ? 2 :
						( RS_E&&cal_i_W&&Ers==Wrt&&Ers!=0 ) ? 2 :
						( RS_E&&load_W&&Ers==Wrt&&Ers!=0 ) ? 2 :
						( RS_E&&jal_W&&Ers==5'h1f ) ? 5 : 0;
	
	assign M_RD2_E_Op = ( RT_E&&cal_r_M&&Ert==Mrd&&Ert!=0 ) ? 1 :
						( RT_E&&cal_i_M&&Ert==Mrt&&Ert!=0 ) ? 1 :
						( RT_E&&jal_M&&Ert==5'h1f ) ? 4 :
						( RT_E&&cal_r_W&&Ert==Wrd&&Ert!=0 ) ? 2 :
						( RT_E&&cal_i_W&&Ert==Wrt&&Ert!=0 ) ? 2 :
						( RT_E&&load_W&&Ert==Wrt&&Ert!=0 ) ? 2 :
						( RT_E&&jal_W&&Ert==5'h1f ) ? 5 : 0;
	
	assign M_RD2_M_Op = ( RT_M&&cal_r_W&&Mrt==Wrd&&Mrt!=0 ) ? 2 :
						( RT_M&&cal_i_W&&Mrt==Wrt&&Mrt!=0 ) ? 2 :
						( RT_M&&load_W&&Mrt==Wrt&&Mrt!=0 ) ? 2 :
						( RT_M&&jal_W&&Mrt==5'h1f ) ? 5 : 0;

endmodule

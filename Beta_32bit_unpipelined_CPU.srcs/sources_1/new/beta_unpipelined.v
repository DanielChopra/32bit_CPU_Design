`timescale 1ns / 1ps
module beta_unpipelined(input clk,rst,output clk_2,output[31:0]wd);

wire [31:0]rd1,rd2,alu_out,mem_read,pc_pls4,A,B,ldr_ea,inst_addr,id;
wire [3:0]alufn;
wire [2:0]pcsel;
wire [1:0]WDSEL;
wire ASEL,BSEL,MOE,MWR,RA2SEL,WASEL,WERF,z;

reg [31:0]wd;
reg clk_2 = 0;


always@(negedge clk) clk_2 <= ~clk_2;

//always@(WDSEL,pc_pls4,alu_out,mem_read)
always@(posedge clk)
begin
    case(WDSEL)
        2'd0 : wd <= pc_pls4;
        2'd1 : wd <= alu_out;
        2'd2 : wd <= mem_read;
        default : wd <= 32'bz;
    endcase
end

//---  memory -----//
inst_mem memory(.ID(id),.clk(clk_2),.we(MWR),.oe(MOE),.drw_addr(alu_out),.WD(rd2),.RD(mem_read),.ir_addr(inst_addr[5:0]));       

//----- reg files ----//
Register_File regfiles(.RD1(rd1),.RD2(rd2),.WD(wd),.RA1(id[20:16]),.RA2(id[15:11]),
                        .RA2SEL(RA2SEL),.WASEL(WASEL),.WA(id[25:21]),.clk(clk_2),.we(WERF)); 

//----- Control block ---------//
Control_Logic_v2 cl(.opcode(id[31:26]),.clk(clk),.ASEL(ASEL),.BSEL(BSEL),.MOE(MOE),.MWR(MWR),.ALUFN(alufn),
                    .WDSEL(WDSEL),.Z(z),.WERF(WERF),.pcsel(pcsel),.RA2SEL(RA2SEL),.WASEL(WASEL));   

//------ ALU -------//
ALU alu_block (.ALU_fn(alufn),.A(A),.B(B),.result(alu_out));  

//---- branch condition check -----//
Branch_Cond branch_check (.RD1(rd1),.Z(z));  

//------ sign extend asel,bsel-------//
sign_extn absel(.ASEL(ASEL),.BSEL(BSEL),.ID(id[15:0]),.A(A),.B(B),.RD1(rd1),.RD2(rd2),.ldr_ea(ldr_ea));

//---- program counter----//
Program_Counter pc(.clk(clk_2),.rst(rst),.pc_pls4(pc_pls4),.addr(inst_addr),.JT(rd1),.PCSEL(pcsel),
                   .ldr_ea(ldr_ea),.ID(id[15:0]));
endmodule

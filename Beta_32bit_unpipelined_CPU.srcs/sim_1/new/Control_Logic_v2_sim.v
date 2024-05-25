`timescale 1ns / 1ps
module Control_Logic_v2_sim();

reg clk,Z,illop;
reg [5:0]opcode;

wire ASEL,BSEL,MOE,MWR,RA2SEL,WASEL,WERF;
wire [3:0]ALUFN;
wire [2:0]pcsel;
wire [1:0]WDSEL;

Control_Logic_v2 dut(.opcode(opcode),.clk(clk),.ASEL(ASEL),.BSEL(BSEL),.MOE(MOE),.MWR(MWR),.ALUFN(ALUFN),
                     .illop(illop),.WDSEL(WDSEL),.Z(Z),.WERF(WERF),.pcsel(pcsel),.RA2SEL(RA2SEL),.WASEL(WASEL));
                     
initial 
begin
    clk = 1'b1;
    forever #5 clk = ~clk;                 
end

initial
begin
    #10  opcode = 6'b100000; Z = 0; illop = 0;
    #10  opcode = 6'b011000; Z = 0; illop = 0;
    #10  opcode = 6'b011011; Z = 0; illop = 0;
    #10  opcode = 6'h22;     Z = 0; illop = 0;
    #10  opcode = 6'h1f;     Z = 0; illop = 1;
    #10  opcode = 6'h1c;     Z = 1; illop = 0;  
    //$display("Current simulation time = %t", $time);
    $monitor("time=%3d, op=%h, asel=%b, bsel=%b, moe=%b, pcsel=%d \n",$time, opcode, ASEL, BSEL, MOE, pcsel); 
end
endmodule

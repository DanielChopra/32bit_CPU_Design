`timescale 1ns / 1ps
module Register_File(output [31:0] RD1,RD2,
                     input  [31:0] WD,
                     input  [4:0] RA1,RA2,WA,
                     input clk,we,RA2SEL,WASEL);

reg [31:0]RF[0:31];
wire[4:0]ra2,wa;

initial 
begin
    RF[31] = 32'h0000_0000;
    RF[2]  = 32'h0000_0005;
    RF[9]  = 32'h0000_000e;
    //$readmemh("D:/Vivado_projects/practice/practice/reg_values.txt",ram);
end
//always@(RF[6'h1f]) RF[6'h1f] = 32'h0000_0000;
// -----  Read Data ------//
assign RD1 = RF[RA1];
assign RD2 = RF[ra2];
assign ra2 = RA2SEL ? WA:RA2;
assign wa  =  WASEL ? 5'd30:WA;
// ----- Write Data ------//
always@(posedge clk)
begin
    if(we)
        RF[wa] <= WD;    
end   
endmodule

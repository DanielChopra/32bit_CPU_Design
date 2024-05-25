`timescale 1ns / 1ps
module SRAM(output [31:0]RD,
            input  [31:0]WD,
            input  [5:0]drw_addr,
            input clk,we,oe);
            
reg [7:0]mem[3:0][1:0];
reg [31:0]temp_d;



always@(posedge clk)
begin
    if(we)
        mem[drw_addr[5:2]][drw_addr[1:0]] <= WD[7:0];
    temp_d[7:0] <= mem[drw_addr[5:2]][drw_addr[1:0]];
end

always@(posedge clk)
begin
    if(we)
        mem[drw_addr[5:2]][drw_addr[1:0]+1] <= WD[15:8];
    temp_d[15:8] <= mem[drw_addr[5:2]][drw_addr[1:0]+1] <= WD[15:8];
end
     
always@(posedge clk)
begin
    if(we)
        mem[drw_addr[5:2]][drw_addr[1:0]+2] <= WD[23:16];
    temp_d[23:16] <= mem[drw_addr[5:2]][drw_addr[1:0]+2] <= WD[23:16];
end      

always@(posedge clk)
begin
    if(we)
        mem[drw_addr[5:2]][drw_addr[1:0]+3] <= WD[31:24];
    temp_d[31:24] <= mem[drw_addr[5:2]][drw_addr[1:0]+3] <= WD[31:24];
end

assign RD = (oe&!we)?temp_d:32'd0;      
endmodule

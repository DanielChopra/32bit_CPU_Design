`timescale 1ns / 1ps
module beta_tb();
reg clk,rst;//WERF,WASEL;
//reg[4:0]RA2SEL;
//reg[31:0]wd,id;

wire[31:0]wd;
wire clk_2;

beta_unpipelined dut(.clk(clk),.rst(rst),.clk_2(clk_2),.wd(wd));

//Register_File regfiles(.RD1(rd1),.RD2(rd2),.WD(wd),.RA1(id[20:16]),.RA2(id[15:11]),
//                        .RA2SEL(RA2SEL),.WASEL(WASEL),.WA(id[25:21]),.clk(clk_2),.we(WERF));

initial
begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial
begin
    rst = 1'b0;
    //#99 rst = 1'b1;
    //#6 rst = 1'b0;
    
    $display("Current simulation time = %t", $time);
end
endmodule

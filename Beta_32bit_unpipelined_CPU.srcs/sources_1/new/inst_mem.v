`timescale 1ns / 1ps
module inst_mem(output reg [31:0]ID,
                output [31:0]RD,
                input  [31:0]WD,
                input  [5:0] ir_addr,drw_addr,
                input clk,we,oe);
reg [31:0]ram[0:63];
reg [31:0]temp_id;

initial $readmemh("D:/Vivado_projects/practice/practice/ldst_pgm.txt",ram);

always@(negedge clk)
begin
    if(we) 
        ram[drw_addr] <= WD;
    temp_id <= ram[drw_addr]; 
end
assign RD = (oe & !we)?(temp_id):(32'hz);

always@(posedge clk)
    ID <= ram[ir_addr];
endmodule



//`timescale 1ns / 1ps
//module inst_mem(output reg [31:0]ID,
//                output [31:0]RD,
//                input  [31:0]WD,
//                input  [5:0] ir_addr,drw_addr,
//                input clk,we,oe);
//reg [31:0]ram[63:0];
//reg [31:0]temp_id;
//always@(posedge clk)
//begin
//    if(we) 
//        ram[drw_addr] <= WD;
//    temp_id <= ram[drw_addr]; 
//end
//assign RD = (oe & !we)?(temp_id):(32'hz);

//always@(posedge clk)
//    ID <= ram[ir_addr];
//endmodule
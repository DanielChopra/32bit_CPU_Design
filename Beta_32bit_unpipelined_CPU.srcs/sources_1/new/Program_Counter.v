`timescale 1ns / 1ps
module Program_Counter(output [31:0]addr,pc_pls4,ldr_ea,
                       input  [31:0]JT,
                       input  [15:0]ID,
                       input  [2:0]PCSEL,
                       input clk,rst);
                       
reg [31:0]pc = 32'd0;
wire [31:0]ext_addr,pc_4,ldr_ea;

assign addr = pc;
assign ext_addr = {{16{ID[15]}},ID};
assign pc_4 = pc + 32'd1;
assign pc_pls4 = pc_4;
assign ldr_ea = pc_4 + (ext_addr<<2);
always@(posedge clk)
begin
    if(rst)
        pc <= 32'd0;
    else
    begin
        case(PCSEL)
            3'h0 : pc <= pc_4;
            3'h1 : pc <= ldr_ea;
            3'h2 : pc <= JT;
            3'h3 : pc <= 32'd4;
            3'h4 : pc <= 32'd8;
            default : pc <= 32'd0;
        endcase 
    end
end
endmodule

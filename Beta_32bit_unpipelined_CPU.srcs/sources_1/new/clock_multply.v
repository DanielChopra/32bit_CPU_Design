`timescale 1ns / 1ps
module clock_multply(input clk_in);
reg clk_out = 0;
reg count = 0;
always@(posedge clk_in)
begin
if(count < 1)
    count <= count + 1;
else
    begin
    count <= 0;
    clk_out <= ~clk_out;
    end
end
endmodule

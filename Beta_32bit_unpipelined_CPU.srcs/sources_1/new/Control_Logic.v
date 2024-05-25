`timescale 1ns / 1ps
module Control_Logic(output reg [12:0]control_sig,
                     output reg [2:0]pcsel,
                     input [5:0]opcode,
                     input clk,Z,illop);

always@(posedge clk)
begin
    case(opcode)
        //-- ADD,ADDC ---//
        6'b100_000 : control_sig = 13'b0000_0_0_0_0_0_0_01_1;
        6'b110_000 : control_sig = 13'b0000_0_1_0_0_0_0_01_1;
        //-- SUB,SUBC ---//
        6'b100_001 : control_sig = 13'b0001_0_0_0_0_0_0_01_1;
        6'b110_001 : control_sig = 13'b0001_0_1_0_0_0_0_01_1;
        //-- AND,ANDC --//
        6'b101_000 : control_sig = 13'b0010_0_0_0_0_0_0_01_1;
        6'b111_000 : control_sig = 13'b0010_0_1_0_0_0_0_01_1;
        //-- OR,ORC--//
        6'b101_001 : control_sig = 13'b0011_0_0_0_0_0_0_01_1;
        6'b111_001 : control_sig = 13'b0011_0_1_0_0_0_0_01_1;
        //--XOR,XORC
        6'b101_010 : control_sig = 13'b0100_0_0_0_0_0_0_01_1;
        6'b111_010 : control_sig = 13'b0100_0_1_0_0_0_0_01_1;
        //--XNOR,XNORC
        6'b101_011 : control_sig = 13'b0101_0_0_0_0_0_0_01_1;
        6'b111_011 : control_sig = 13'b0101_0_1_0_0_0_0_01_1;
        //--CMPEQ,CMPEQC
        6'b100_100 : control_sig = 13'b0110_0_0_0_0_0_0_01_1;
        6'b110_100 : control_sig = 13'b0110_0_1_0_0_0_0_01_1;
        //--CMPLE,CMPLEC
        6'b100_110 : control_sig = 13'b0111_0_0_0_0_0_0_01_1;
        6'b110_110 : control_sig = 13'b0111_0_1_0_0_0_0_01_1;
        //--CMPLT,CMPLTC
        6'b100_101 : control_sig = 13'b1000_0_0_0_0_0_0_01_1;
        6'b110_101 : control_sig = 13'b1000_0_1_0_0_0_0_01_1;
        //--SHL,SHLC
        6'b101_100 : control_sig = 13'b1001_0_0_0_0_0_0_01_1;
        6'b111_100 : control_sig = 13'b1001_0_1_0_0_0_0_01_1;
        //--SHR,SHRC
        6'b101_101 : control_sig = 13'b1010_0_0_0_0_0_0_01_1;
        6'b111_101 : control_sig = 13'b1010_0_1_0_0_0_0_01_1;
        //--SRA,SRAC
        6'b101_110 : control_sig = 13'b1011_0_0_0_0_0_0_01_1;
        6'b111_110 : control_sig = 13'b1011_0_1_0_0_0_0_01_1;
        //--LD
        6'b011_000 : control_sig = 13'b0000_0_1_1_0_0_0_10_1;
        //--ST
        6'b011_001 : control_sig = 13'b0000_0_1_0_1_1_0_XX_0;
        //--JMP
        6'b011_011 : control_sig = 13'bXXXX_X_X_X_0_X_0_00_1;
        //--BEQ
        6'b011_100 : control_sig = 13'bXXXX_X_X_X_0_X_0_00_1;
        //--BNE
        6'b011_101 : control_sig = 13'bXXXX_X_X_X_0_X_0_00_1;
        default:control_sig = 13'bXXXX_X_X_X_0_X_1_00_1;
    endcase
end


always@(posedge clk)
begin
    if(illop)
        begin pcsel = 3'd3; end
    else
        case(opcode)
            6'b011100 : pcsel = Z ? (3'd1) : (3'd0);
            6'b011101 : pcsel = Z ? (3'd0) : (3'd1);
            6'b011011 : pcsel = 3'd2; 
            default : pcsel = 3'd0;
        endcase
end
endmodule

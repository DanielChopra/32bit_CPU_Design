`timescale 1ns / 1ps
module ALU(output reg [31:0]result,
           input  signed [31:0]A,B,
           input  [3:0]ALU_fn);
always@(*)
    case(ALU_fn)
        4'h0 : begin result = A+B;  end
        4'h1 : begin result = A-B;  end
        4'h2 : begin result = A&B;  end
        4'h3 : begin result = A|B;  end
        4'h4 : begin result = A^B;  end
        4'h5 : begin result = A~^B; end
        4'h6 : begin result = (A==B)?32'd1:32'd0;  end
        4'h7 : begin result = (A<=B)?32'd1:32'd0;  end
        4'h8 : begin result = (A<B)?32'd1:32'd0;   end
        4'h9 : begin result = A<<B[4:0];  end
        4'hA : begin result = A>>B[4:0];  end
        4'hB : begin result = A>>>B[4:0]; end
        default: begin result = 32'bZ;  end
    endcase
endmodule

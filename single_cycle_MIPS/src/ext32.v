module ext32(input [15:0]imm, input [1:0]extop, input [31:0]b, input b_sel, output [31:0]alu_b);
    reg[31:0]imm32;

    assign alu_b=(b_sel)?imm32:b;

    always@(imm or extop)
    case(extop)
        2'b00:
            imm32={{16'b0},imm};
        2'b01:
            imm32={{16{imm[15]}},imm};
        2'b10:
            imm32={imm,{16'b0}};
        default:
            imm32=0;
    endcase
endmodule

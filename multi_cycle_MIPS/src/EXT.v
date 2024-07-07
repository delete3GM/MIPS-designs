module EXT(imm, EXTop, imm_extend);
    input [1:0]EXTop;
    input [15:0]imm;
    output [31:0]imm_extend;

    assign imm_extend=(EXTop == 2'b00)? {16'h0000,imm[15:0]}:
           (EXTop == 2'b01)? {{16{imm[15]}},imm[15:0]}:
           (EXTop == 2'b10)? {imm[15:0],16'h0000}:{{14{imm[15]}},imm[15:0],2'b00};

endmodule

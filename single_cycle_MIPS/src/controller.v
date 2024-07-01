module controller(input[31:0] din, output[4:0]rd, output[4:0]rs, output[4:0]rt, output[5:0]funct, output[5:0]opcode, output[15:0]imm);
    assign funct=din[5:0];
    assign opcode=din[31:26];
    assign rd=din[15:11];
    assign rs=din[25:21];
    assign rt=din[20:16];
    assign imm=din[15:0];
endmodule

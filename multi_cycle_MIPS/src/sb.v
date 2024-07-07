module sb(busB,dout_DM,SBout);
    input [31:0]busB,dout_DM;
    output [31:0]SBout;

    assign SBout={dout_DM[31:8],busB[7:0]};

endmodule

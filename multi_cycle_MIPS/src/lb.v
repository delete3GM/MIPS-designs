module lb(DMin,LBout);
    input [31:0]DMin;
    output [31:0]LBout;

    assign LBout = {{24{DMin[7]}},DMin[7:0]};

endmodule

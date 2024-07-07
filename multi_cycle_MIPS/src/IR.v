module IR(clk,instruction_in,IRWr,instruction);
    input clk,IRWr;
    input [31:0]instruction_in;
    output reg [31:0] instruction;

    always @(posedge clk)
        if(IRWr)
            instruction <= instruction_in;

endmodule

module B(clk,busB_in,busB);
    input clk;
    input [31:0] busB_in;
    output reg [31:0]busB;
    
    always @(posedge clk)
        busB <= busB_in;

endmodule

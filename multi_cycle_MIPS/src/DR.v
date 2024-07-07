module DR(clk,dout_DM_in,dout_DM);
    input clk;
    input [31:0]dout_DM_in;
    output [31:0]dout_DM;
    reg [31:0] dout_DM;
    
    always@(posedge clk)
        dout_DM = dout_DM_in;

endmodule

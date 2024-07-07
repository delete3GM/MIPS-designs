module PC(clk,reset,npc,pc,PCwr);
    input clk,reset,PCwr;
    input [31:0]npc;
    output [31:0]pc;

    reg [31:0]pc;

    always@(posedge clk or posedge reset) begin
        if(reset)
            pc <= 32'h0000_3000;
        else
            if(PCwr)
                pc <= npc;
    end

endmodule

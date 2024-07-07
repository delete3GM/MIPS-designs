module dm(addr,din,DMwr,clk,dout_DM);
    input [9:0]addr;
    input [31:0]din;
    input clk,DMwr;
    output [31:0]dout_DM;
    reg [7:0] dm[1023:0];

    integer i;
    initial begin
        for(i=0;i<1024;i=i+1)
            dm[i]=0;
    end

    assign dout_DM={dm[addr+3],dm[addr+2],dm[addr+1],dm[addr]};

    always @(posedge clk) begin
        if(DMwr) begin
            dm[addr]=din[7:0];
            dm[addr+1]=din[15:8];
            dm[addr+2]=din[23:16];
            dm[addr+3]=din[31:24];
        end
    end

endmodule

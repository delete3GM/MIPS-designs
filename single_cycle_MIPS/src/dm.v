module dm_1k(addr, din, we, clk, dout) ;
    input   [9:0]  addr ;
    input   [31:0]  din ;
    input           we ;    // memory write enable
    input           clk ;
    output  [31:0]  dout ;
    reg     [7:0]  dm[1023:0] ;//1024 bytes
    integer i;
    
    initial begin
        for (i = 0;i < 1024;i = i+1)
            dm[i] = 8'b0;
    end

    always @ (posedge clk) begin
        if(we) begin
            dm[addr[9:2]]<=din[7:0];
            dm[addr[9:2]+1]<=din[15:8];
            dm[addr[9:2]+2]<=din[23:16];
            dm[addr[9:2]+3]<=din[31:24];
        end
    end
    assign dout={dm[addr[9:2]+3],dm[addr[9:2]+2],dm[addr[9:2]+1],dm[addr[9:2]]};
endmodule

module ifu(input clk,input reset, input j_sel,input jr_sel,input npc_sel,input zero , input [31:0]jr,output reg [31:0]pc,output  [31:0]  dout);
    wire [31:0]npc,t4,t3,t2,t1,t0,extout,temp,j;
    wire [15:0]imm;
    reg     [7:0]  im[1023:0] ;

    assign imm=dout[15:0];
    assign temp={{16{imm[15]}},imm};
    assign extout=temp<<2;//计算偏移量

    assign j={pc[31:28],dout[25:0],2'b0};//计算目标地址

    assign dout={im[pc[9:0]],im[pc[9:0]+1],im[pc[9:0]+2],im[pc[9:0]+3]};
    
    always @(posedge clk , posedge reset) begin
        if(reset)
            pc<=32'h0000_3000;
        else
            pc<=npc;
    end

    assign npc=(jr_sel)?jr:t3;//寄存器跳转
    assign t3=(j_sel)?j:t2;//跳转指令
    assign t2=(npc_sel&&zero)?t1:t0;//条件跳转
    assign t0=pc+4;//顺序执行
    assign t1=t0+extout;//条件分支
endmodule

`include "src/A.v"
`include "src/ALU.v"
`include "src/ALUOut.v"
`include "src/B.v"
`include "src/controller.v"
`include "src/dm.v"
`include "src/DR.v"
`include "src/EXT.v"
`include "src/GPR.v"
`include "src/im.v"
`include "src/IR.v"
`include "src/lb.v"
`include "src/NPC.v"
`include "src/PC.v"
`include "src/sb.v"
module mips(clk,reset);
    input clk;
    input reset;
    wire [31:0] busA, busA_in;
    wire [31:0] busB, busB_in;
    wire [31:0] imm_extend;
    wire [31:0] ALUout,ALUout_in;
    wire [31:0] dout;
    wire [31:0] instruction;
    wire [31:0] busW;
    wire [31:0] PC;
    wire [31:0] NPC;
    wire [31:0] PC_add4;
    wire PCwr, IRwr, DMwr, GPRwr, Bsel, zero, ov, sb_sel, lb_sel;
    wire [2:0] ALUOp;
    wire [1:0] NPCop,EXTop,WDsel,GPRsel;
    wire [4:0] rd;
    wire [31:0] B;
    wire [31:0] DM_RD, SBout, LBout;
    wire [31:0] dout_DM, dout_DM_in;
    wire [31:0] din;

    assign rd=(GPRsel==2'b00)?instruction[15:11]:(GPRsel==2'b01)?instruction[20:16]:(GPRsel==2'b10)?31:0;
    assign busW=(WDsel==2'b00)?ALUout:(WDsel==2'b01)?dout_DM:(WDsel==2'b10)?PC_add4:0;
    assign B=(Bsel==0)?busB:imm_extend;
    assign din=(sb_sel)?SBout:busB;
    assign dout_DM_in=(lb_sel)?LBout:DM_RD;

    PC PC1(clk,reset,NPC,PC,PCwr);
    im im1(PC[9:0],dout);
    IR IR1(clk,dout,IRwr,instruction);
    controller controller1(clk,reset,instruction[31:26],instruction[5:0],PCwr,IRwr,GPRwr,DMwr,Bsel,EXTop,ALUOp,NPCop,WDsel,GPRsel,zero,sb_sel,lb_sel);
    NPC NPC1(PC,instruction[25:0],busA,NPC,PC_add4,zero,NPCop);
    GPR GPR1(clk,reset,GPRwr,instruction[25:21],instruction[20:16],rd,busW,busA_in,busB_in,ov);
    A A1(clk,busA_in,busA);
    B B1(clk,busB_in,busB);
    EXT EXT1(instruction[15:0],EXTop,imm_extend);
    ALU ALU1(busA,B,ALUOp,zero,ov,ALUout_in,instruction[31:26]);
    ALUOut ALUout1(clk,ALUout_in,ALUout);
    dm dm1(ALUout[9:0],din,DMwr,clk,DM_RD);
    sb sb1(busB,DM_RD,SBout);
    lb lb1(DM_RD,LBout);
    DR DR1(clk,dout_DM_in,dout_DM);

endmodule

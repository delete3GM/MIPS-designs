`include "src/alu.v"
`include "src/controller.v"
`include "src/controllersel.v"
`include "src/gpr.v"
`include "src/ifu.v"
`include "src/im.v"
`include "src/ext32.v"
`include "src/dm.v"
module mips(clk, rst) ;
    input           clk ;   
    input           rst ;  
    wire [9:0]addrdm;
    wire [31:0]a,b,alu_b,aluout,dmout,pc,dout,din,jr;
    wire [1:0]aluop,extop;
    wire zero,flag,regwr,memwrite,memtoreg,alusrc,j_sel,npc_sel,l,rd_dst,flag_sel,jr_sel,jal_sel,addi_sel,slt_sel,flagsel;
    wire [5:0]opcode,funct;
    wire [4:0]rs,rt,rd,rdtmp;
    wire [15:0]imm;

    assign addrdm=aluout[9:0];
    assign rd=(rd_dst)?rdtmp:rt;
    assign flagsel=addi_sel;
    assign din=(memtoreg)?dmout:aluout;

    alu alu1(a,alu_b,aluop,aluout,zero,flag,slt_sel,flagsel);
    controllersel sel(rt,opcode,funct,aluop,regwr,extop,memwrite,memtoreg,alusrc,j_sel,npc_sel,rd_dst,flag_sel,jr_sel,jal_sel,addi_sel,slt_sel);
    dm_1k dm1(addrdm, b, memwrite, clk, dmout);
    gpr gpr1(rs,rt,rd,din,flag_sel,flag,pc,clk,rst,jal_sel,jr_sel,regwr,a,b,addi_sel);
    ifu ifu1(clk,rst,j_sel,jr_sel,npc_sel,zero,aluout,pc,dout);
    controller ctrl1(dout,rdtmp,rs,rt,funct,opcode,imm);
    ext32 ext(imm,extop,b,alusrc,alu_b);

endmodule

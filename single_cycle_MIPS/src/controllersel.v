module controllersel(rt,opcode,funct,aluop,regwr,extop,memwrite,memtoreg,alusrc,j_sel,npc_sel,rd_dst,flag_sel,jr_sel,jal_sel,addi_sel,slt_sel);
    input [4:0]rt;
    input [5:0]funct;
    input [5:0]opcode;
    output reg regwr,memwrite,memtoreg,alusrc,j_sel,npc_sel,rd_dst,flag_sel;
    output reg [1:0]aluop,extop;
    output jr_sel,jal_sel,addi_sel,slt_sel;
    assign jal_sel=(opcode==6'b000011);
    assign jr_sel=(opcode==6'b000000&&funct==6'b001000);
    assign addi_sel=(opcode==6'b001000);
    assign slt_sel=(opcode==6'b000000&&funct==6'b101010);
    always @ (funct or opcode) begin
        if(opcode==6'b001101)//ori
        begin
            j_sel=0;
            aluop=2'b10;//or
            extop=2'b00;
            regwr=1;
            memwrite=0;
            alusrc=1;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000000&&funct==6'b100001)//addu
        begin
            j_sel=0;
            aluop=2'b00;//add
            extop=2'b00;
            regwr=1;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=1;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000000&&funct==6'b100011)//subu
        begin
            j_sel=0;
            aluop=2'b01;//sub
            extop=2'b00;
            regwr=1;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=1;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b100011)//lw
        begin
            j_sel=0;
            aluop=2'b00;//add
            extop=2'b01;
            regwr=1;
            memwrite=0;
            alusrc=1;
            memtoreg=1;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b101011)//sw
        begin
            j_sel=0;
            aluop=2'b00;//add
            extop=2'b01;
            regwr=0;
            memwrite=1;
            alusrc=1;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000100)//beq
        begin
            j_sel=0;
            aluop=2'b01;//sub
            extop=2'b00;
            regwr=0;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=0;
            npc_sel=1;
            flag_sel=0;
        end
        if(opcode==6'b001111)//lui
        begin
            j_sel=0;
            aluop=2'b00;//add
            extop=2'b10;
            regwr=1;
            memwrite=0;
            alusrc=1;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000010)//j
        begin
            j_sel=1;
            aluop=2'b00;//add
            extop=2'b00;
            regwr=0;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=0;
            npc_sel=1;
            flag_sel=0;
        end
        if(opcode==6'b001000)//addi
        begin
            j_sel=0;
            aluop=2'b00;//add
            extop=2'b01;
            regwr=1;
            memwrite=0;
            alusrc=1;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=1;
        end
        if(opcode==6'b001001)//addiu
        begin
            j_sel=0;
            aluop=2'b00;//add
            extop=2'b01;
            regwr=1;
            memwrite=0;
            alusrc=1;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000000&&funct==6'b101010)//slt
        begin
            j_sel=0;
            aluop=2'b01;//sub
            extop=2'b00;
            regwr=1;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=1;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000011)//jar;
        begin
            j_sel=1;
            aluop=2'b00;//add
            extop=2'b00;
            regwr=1;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
        if(opcode==6'b000000&&funct==6'b001000)//jr
        begin
            j_sel=1;
            aluop=2'b00;//add
            extop=2'b00;
            regwr=0;
            memwrite=0;
            alusrc=0;
            memtoreg=0;
            rd_dst=0;
            npc_sel=0;
            flag_sel=0;
        end
    end
endmodule

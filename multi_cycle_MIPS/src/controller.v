module controller(clk,reset,opcode,funct,PCWr,IRWr,GPRWr,DMWr,Bsel,EXTop,ALUOp,NPCop,WDsel,GPRsel,zero,sb_sel,lb_sel);
    input clk,reset,zero;
    input [5:0]opcode,funct;
    output PCWr,IRWr,GPRWr,DMWr,Bsel,sb_sel,lb_sel;
    output [1:0] EXTop,NPCop,WDsel,GPRsel;
    output [2:0]ALUOp;
    reg [3:0]FSM;
    wire addu,subu,ori,lw,sw,beq,j,lui,addi,addiu,slt,jal,jr,sb,lb;
    wire t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;
    parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,s4=4'b0100,s5=4'b0101,s6=4'b0110,s7=4'b0111,s8=4'b1000,s9=4'b1001;

    assign addu=(opcode==6'b000000&&funct==6'b100001)?1:0;
    assign subu=(opcode==6'b000000&&funct==6'b100011)?1:0;
    assign slt =(opcode==6'b000000&&funct==6'b101010)?1:0;
    assign jr = (opcode==6'b000000&&funct==6'b001000)?1:0;
    assign addiu=(opcode==6'b001001)?1:0;
    assign addi=(opcode==6'b001000)?1:0;
    assign ori=(opcode==6'b001101)?1:0;
    assign beq=(opcode==6'b000100)?1:0;
    assign lui=(opcode==6'b001111)?1:0;
    assign jal=(opcode==6'b000011)?1:0;
    assign lw=(opcode==6'b100011)?1:0;  
    assign sw=(opcode==6'b101011)?1:0;
    assign lb=(opcode==6'b100000)?1:0;
    assign sb=(opcode==6'b101000)?1:0;
    assign j=(opcode==6'b000010)?1:0;

    always @(posedge clk or posedge reset) begin
        if(reset) 
            FSM<=s0;
        
        else begin
            case(FSM)
                s0:
                    FSM<=s1;
                s1:
                case(opcode)
                    6'b100011:
                        FSM<=s2;//lw
                    6'b100000:
                        FSM<=s2;//lb
                    6'b101000:
                        FSM<=s2;//sb
                    6'b101011:
                        FSM<=s2;//sw
                    6'b000000:
                        FSM<=s6;//addu|subu|slt|jr
                    6'b001101:
                        FSM<=s6;//ori
                    6'b001111:
                        FSM<=s6;//lui
                    6'b001000:
                        FSM<=s6;//addi
                    6'b001001:
                        FSM<=s6;//addiu
                    6'b000100:
                        FSM<=s8;//beq
                    6'b000010:
                        FSM<=s9;//j
                    6'b000011:
                        FSM<=s9;//jal
                endcase
                //MA
                s2:
                case(opcode)
                    6'b100011:
                        FSM<=s3;//lw
                    6'b100000:
                        FSM<=s3;//lb
                    6'b101000:
                        FSM<=s5;//sb
                    6'b101011:
                        FSM<=s5;//sw
                endcase
                //MR
                s3:
                    FSM<=s4;//lw|lb
                //Memwrite
                s4:
                    FSM<=s0;//lw|lb
                //Memwrite
                s5:
                    FSM<=s0;//sw|sb
                //Exe
                s6:
                    FSM<=s7;//addu|subu|slt|jr|ori|lui|addi|addiu
                //AluWrite
                s7:
                    FSM<=s0;//addu|subu|slt|jr|ori|lui|addi|addiu
                //Branch
                s8:
                    FSM<=s0;//beq
                //Jmp
                s9:
                    FSM<=s0;//j|jal
            endcase
        end
    end
	//状态解码s0-s9
    assign t0=(~FSM[3])&&(~FSM[2])&&(~FSM[1])&&(~FSM[0]); // fetch 
    assign t1=(~FSM[3])&&(~FSM[2])&&(~FSM[1])&&( FSM[0]); // DCD/RF 
    assign t2=(~FSM[3])&&(~FSM[2])&&( FSM[1])&&(~FSM[0]); // MA 
    assign t3=(~FSM[3])&&(~FSM[2])&&( FSM[1])&&( FSM[0]); // MR 
    assign t4=(~FSM[3])&&( FSM[2])&&(~FSM[1])&&(~FSM[0]); // MemWR 
    assign t5=(~FSM[3])&&( FSM[2])&&(~FSM[1])&&( FSM[0]); // MW 
    assign t6=(~FSM[3])&&( FSM[2])&&( FSM[1])&&(~FSM[0]); // Exe 
    assign t7=(~FSM[3])&&( FSM[2])&&( FSM[1])&&( FSM[0]); // AluWB 
    assign t8=( FSM[3])&&(~FSM[2])&&(~FSM[1])&&(~FSM[0]); // Branch 
    assign t9=( FSM[3])&&(~FSM[2])&&(~FSM[1])&&( FSM[0]); // Jmp 

	//生成输出信号
    assign PCWr=t0||(t8&&zero)||t9||(jr&&t7);
    assign IRWr=t0;
    assign GPRWr=((lw||lb)&&t4)||((addu||subu||ori||lui||addi||addiu||slt)&&t7)||(jal&&t9);
    assign DMWr=(sw||sb)&&t5;
    assign EXTop[0]=((sw||sb)&&(t1||t2||t5))||((lw||lb)&&(t1||t2||t3||t4))||((addi||addiu)&&(t1||t6||t7));
    assign EXTop[1]=(lui&&(t1||t6||t7));
    assign Bsel=((addi||addiu||ori||lui)&&(t1||t6||t7))||((sw||sb)&&(t1||t2||t5))||((lw||lb)&&(t1||t2||t3||t4));
    assign ALUOp[0]=(subu&&(t1||t6||t7))||(beq&&(t1||t8));
    assign ALUOp[1]=((ori||lui)&&(t1||t6||t7));
    assign ALUOp[2]=(slt&&(t1||t6||t7));
    assign WDsel[0]=((lw||lb)&&(t1||t2||t3||t4));
    assign WDsel[1]=(jal&&(t1||t9));
    assign GPRsel[0]=((ori||addi||addiu||lui)&&(t1||t6||t7))||((lw||lb)&&(t1||t2||t3||t4));
    assign GPRsel[1]=(jal&&(t1||t9));
    assign NPCop[0]=(beq&&(t1||t8))||(jr&&(t1||t6||t7));
    assign NPCop[1]=((j||jal)&&(t1||t9))||(jr&&(t1||t6||t7));
    assign lb_sel=(lb&&(t1||t2||t3||t4));
    assign sb_sel=(sb&&(t1||t2||t5));

endmodule

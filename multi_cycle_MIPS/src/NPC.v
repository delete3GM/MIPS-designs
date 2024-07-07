module NPC(PC, imm, jr_PC, NPC, PC_Add4, zero, NPCOp);
    input zero;
    input [1:0]NPCOp;
    input [31:0] PC,jr_PC;
    input [25:0] imm;
    output [31:0] NPC, PC_Add4;
    
    wire [31:0] t0, t1, t2, t3, t1_temp;

    assign PC_Add4 = PC;
    assign NPC = (NPCOp == 2'b11)? t3:
           ((NPCOp == 2'b01) && zero)? t1:
           (NPCOp == 2'b10)? t2:t0;
 
    assign t0 = PC + 4; // next
    assign t1_temp = {{14{imm[15]}},imm[15:0],2'b00}; // sign-extend
    assign t1 = PC + t1_temp; // branch instructions' address
    assign t2 = {PC_Add4[31:28],imm[25:0],2'b00}; // jump instructions
    assign t3 = jr_PC; // jr

endmodule

 
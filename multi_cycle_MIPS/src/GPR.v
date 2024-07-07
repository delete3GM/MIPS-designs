module GPR(clk ,reset, RegWr, rs, rt, rd, busW, busA, busB, OV);
    input clk , reset , RegWr , OV ; 
    input [4:0]rs,rt,rd;   
    input [31:0] busW; 
    output [31:0] busA ,busB;
  
    reg [31:0] Regs[31:0];
  
    assign busA = Regs[rs];
    assign busB = Regs[rt];
	
    always@( posedge clk or posedge reset) begin
       	if (reset) begin
            Regs [1]<=0; Regs [2]<=0; Regs [3]<=0; Regs [4]<=0;
            Regs [5]<=0; Regs [6]<=0; Regs [7]<=0; Regs [8]<=0;
            Regs [9]<=0; Regs [10]<=0; Regs [11]<=0; Regs [12]<=0;
            Regs [13]<=0; Regs [14]<=0; Regs [15]<=0; Regs [16]<=0;
         	Regs [17]<=0; Regs [18]<=0; Regs [19]<=0; Regs [20]<=0;
         	Regs [21]<=0; Regs [22]<=0; Regs [23]<=0; Regs [24]<=0;
         	Regs [25]<=0; Regs [26]<=0; Regs [27]<=0; Regs [28]<=32'h00001800;
         	Regs [29]<=32'h00002ffc; Regs [30]<=0; Regs [31]<=0; Regs [0]<=0;
       	end

		else if (RegWr) begin
            Regs[0] <= 32'b0; // $zero == 0
            if (!OV) begin
                Regs[rd] <= busW; 
                Regs[30] <= 32'b0;
            end
            else
                Regs[30] <= (Regs[30] & ~1) | (OV & 1);  //overflow
        end
   	end
	
endmodule




module gpr(input [4:0]rs,  input [4:0]rt, input[4:0]rd, input [31:0]din,input flag_sel,input flag,input [31:0] pc,input clk,input rst,input jal_sel,input jr_sel,input regwr,output [31:0]a, output [31:0]b,input addi_sel);
    reg [31:0]t[31:0];
    integer i;
   
    assign a=(jr_sel)?t[31]:t[rs];
    assign b=t[rt];

    always @(posedge clk or posedge rst) begin
        if(rst)
            for(i=0;i<32;i=i+1)
                t[i]<=0;
        else
            if(regwr) begin
                t[28] = 32'h0000_1800;
                t[29] = 32'h0000_2ffc;
                
                if(jal_sel)
                    t[31]<=pc+4;

                if(flag_sel && flag) // addi overflow
                    t[30][0]<=flag;

                if (addi_sel && (rt != 0) && (flag == 0)) // addi write
                    t[rt] <= din; 

                else if (rd != 0 && addi_sel == 0) // other write
                    t[rd] <= din;
            end
    end
endmodule

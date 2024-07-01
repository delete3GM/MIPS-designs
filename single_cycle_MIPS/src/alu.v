module alu(input [31:0]a, input [31:0]b, input [1:0]aluop, output [31:0] aluout, output zero, output flag,input slt_sel,input flagsel);
    reg [31:0]temp;

    assign aluout=(slt_sel)?temp[31]:temp[31:0];
    
    assign zero=(aluout==0)?1:0;
 
    assign flag = (flagsel) ? ((a[31] == 0 && b[31] == 0 && temp[31] == 1) || (a[31] == 1 && b[31] == 1 && temp[31] == 0)) : 0;

    always@(a or b or aluop) begin
        case(aluop)
            2'b00:
                temp<=a+b;
            2'b01:
                temp<=a-b;
            2'b10:
                temp<=a|b;
            2'b11:
                temp<=0;
            default:
                temp<=0;
        endcase
    end

endmodule

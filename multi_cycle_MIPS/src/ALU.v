module ALU( A_in,B_in,ALUOp,zero,OV,ALUOut,opcode);
  	input [31:0]A_in,B_in;
 	input [2:0]ALUOp;
 	input [5:0]opcode;
  	output [31:0]ALUOut;
  	output zero,OV;
	reg [31:0] ALUOut;

  	assign zero = (ALUOut==0)? 1:0;
  	assign OV = (opcode == 6'b001000)?((A_in[31]==0&&B_in[31]==0&&ALUOut[31]==1) || (A_in[31]==1&&B_in[31]==1&&ALUOut[31]==0)):0; // overflow
	always@( ALUOp or A_in or B_in )
	begin
		case(ALUOp)
			3'b000: ALUOut = A_in + B_in;
			3'b001: ALUOut = A_in - B_in;
			3'b010: ALUOut = A_in | B_in;
			3'b011: ALUOut = A_in & B_in;
			3'b100: begin
            if (A_in[31]> B_in[31])
                ALUOut = 1;
            else
              	begin
                if(A_in[31] == B_in[31])
                 	begin
                    if(((A_in[31] == 0) && ( A_in < B_in )) ||(( A_in[31]==1) && (A_in > B_in)))
                      	ALUOut = 1;
                    else
                      	ALUOut = 0;
                  	end
                else
                  ALUOut = 0;
              	end
            end
          	default: ALUOut = 0;			
		endcase		
	end
	
endmodule
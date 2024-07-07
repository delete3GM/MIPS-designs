module ALUOut(clk,ALUOut_in,ALUOut);
   input clk;
   input [31:0] ALUOut_in;
   output reg [31:0]ALUOut;

   always @(posedge clk) 
	   ALUOut = ALUOut_in;
		
endmodule